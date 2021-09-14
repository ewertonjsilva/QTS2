unit unt_pesq_fornecedor_c;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, frxClass, frxDBSet,
  Datasnap.DBClient, Data.Win.ADODB, frxExportCSV, frxExportBaseDialog,
  frxExportPDF;

type
  Tfrm_pesq_fornecedor_c = class(TForm)
    pnl_pesq: TPanel;
    pnl_info_1: TPanel;
    pnl_info_2: TPanel;
    pnl_info_3: TPanel;
    pnl_info_4: TPanel;
    rbt_nm_fant: TRadioButton;
    rbt_dt: TRadioButton;
    rbt_cnpj: TRadioButton;
    rbt_ambos: TRadioButton;
    rbt_ativo: TRadioButton;
    rbt_inativo: TRadioButton;
    rbt_az: TRadioButton;
    rbt_za: TRadioButton;
    edt_pesquisa: TEdit;
    btn_pesquisa: TBitBtn;
    dbg_resultados: TDBGrid;
    ds_pesq_forn: TDataSource;
    btn_rel: TBitBtn;
    frxDbDtForn: TfrxDBDataset;
    frxRpForn: TfrxReport;
    dsTel: TDataSource;
    frxDbDtTel: TfrxDBDataset;
    qryTelefones: TADOQuery;
    qryTelefonesforn_tel_cod: TAutoIncField;
    qryTelefonesforn_tel_contato: TStringField;
    qryTelefonesforn_tel_tipo: TStringField;
    qryTelefonesforn_tel_numero: TStringField;
    qryTelefonesforn_tel_operadora: TStringField;
    qryTelefonesforn_cod: TIntegerField;
    dsRelForn: TDataSource;
    dldt_forn: TClientDataSet;
    dldt_fornforn_cod: TIntegerField;
    dldt_fornforn_nome: TStringField;
    dldt_fornforn_data: TStringField;
    dldt_fornforn_cnpj: TStringField;
    dldt_fornforn_img: TBlobField;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_pesquisaClick(Sender: TObject);
    procedure rbt_nm_fantClick(Sender: TObject);
    procedure rbt_cnpjClick(Sender: TObject);
    procedure rbt_dtClick(Sender: TObject);
    procedure rbt_ambosClick(Sender: TObject);
    procedure rbt_ativoClick(Sender: TObject);
    procedure rbt_inativoClick(Sender: TObject);
    procedure rbt_azClick(Sender: TObject);
    procedure rbt_zaClick(Sender: TObject);
    procedure btn_relClick(Sender: TObject);
  private
    campoPesq, situacao, ordenacao: String;
    const sqlTel = 'SELECT forn_tel_cod, forn_tel_contato, forn_tel_tipo, ' +
                    'forn_tel_numero, forn_tel_operadora, forn_cod ' +
                    'FROM FORNECEDOR_TELEFONES ';
    const sqlPadrao = 'SELECT forn_cod, forn_nm_fantasia, forn_razao_social, ' +
                      'forn_dt_cad, forn_cnpj, forn_ativo, forn_img, ' +
                      'forn_observacoes FROM FORNECEDORES ';
  public
    { Public declarations }
  end;

var
  frm_pesq_fornecedor_c: Tfrm_pesq_fornecedor_c;

implementation

{$R *.dfm}

uses UDM;

procedure Tfrm_pesq_fornecedor_c.btn_pesquisaClick(Sender: TObject);
var
  validaPesq, auxCnpj : String;
  i : Integer;
begin
  validaPesq := edt_pesquisa.Text;
  DM.qry_pesq_fornecedor.Close;
  DM.qry_pesq_fornecedor.SQL.Clear;
  DM.qry_pesq_fornecedor.SQL.Add(sqlPadrao + campoPesq + situacao + ordenacao);

  if (rbt_nm_fant.Checked = True) then
  begin
    DM.qry_pesq_fornecedor.Parameters.ParamByName('pPesquisa').Value := '%' + edt_pesquisa.Text + '%';
  end;

  if (rbt_dt.Checked = True) then
  begin
    if (validaPesq.Length = 4) then
    begin
      DM.qry_pesq_fornecedor.Parameters.ParamByName('pPesquisa').Value := validaPesq + '%';
    end
    else
    begin
      edt_pesquisa.Clear;
      edt_pesquisa.SetFocus;
      Application.MessageBox(
        'Favor inserir 4 dígitos ao pesquisar pelo ano',
        'Aviso', MB_ICONWARNING);
      Exit;
    end;
  end;

  if (rbt_cnpj.Checked = True) then
  begin
    if ((validaPesq.Length = 14) or (validaPesq.Length = 18)) then
    begin
      if (validaPesq.Length = 18) then
      begin
        ShowMessage(validaPesq);
        auxCnpj := validaPesq;
        validaPesq:= '';
        for i:=1 to Length(auxCnpj) do
        if auxCnpj[i] IN ['0'..'9'] then
        begin
          validaPesq := validaPesq + Copy(auxCnpj, i, 1);
        end;
      end;
      DM.qry_pesq_fornecedor.Parameters.ParamByName('pPesquisa').Value := validaPesq;
    end
    else
    begin
      edt_pesquisa.Clear;
      edt_pesquisa.SetFocus;
      Application.MessageBox(
        'Favor inserir 14 dígitos ao pesquisar o CNPJ sem máscara ' +
        'ou 18 para pesquisa com máscara',
        'Aviso', MB_ICONWARNING);
      Exit;
    end;
  end;

  DM.qry_pesq_fornecedor.Open;

end;

procedure Tfrm_pesq_fornecedor_c.btn_relClick(Sender: TObject);
var
  dataStr, cnpj, cnpj_masc, imagem : String;
  dtString: string;
  dtConvertida: TDateTime;
  separadorData: TFormatSettings;
  i : Integer;
  img: TMemoryStream;
begin
  ds_pesq_forn.DataSet.First;
  dldt_forn.EmptyDataSet;

  img := TMemoryStream.Create;

  while not ds_pesq_forn.DataSet.Eof do
  begin
    cnpj := DM.qry_pesq_fornecedorforn_cnpj.AsString;
    cnpj_masc := '';

    // converter data
    dtString := DM.qry_pesq_fornecedorforn_dt_cad.AsString;
    separadorData.ShortDateFormat := 'yyyy-mm-dd';
    separadorData.DateSeparator := '-';
    dtConvertida := StrToDate(dtString, separadorData);
    dataStr := DateToStr(dtConvertida);

    // inserir máscara no cnpj
    for i:=1 to Length(cnpj) do
    begin
        if ((i = 3) or (i = 6)) then
        begin
          cnpj_masc := cnpj_masc + '.';
        end;
        if (i = 9) then
        begin
          cnpj_masc := cnpj_masc + '/';
        end;
        if (i = 13) then
        begin
          cnpj_masc := cnpj_masc + '-';
        end;
        cnpj_masc := cnpj_masc + Copy(cnpj, i, 1);
    end;

    // passar caminho da imagem
    if (DM.qry_pesq_fornecedorforn_img.Value <> '') then
    begin
      if (FileExists(ExtractFilePath(Application.ExeName) +
          '\Imagens\' + DM.qry_pesq_fornecedorforn_img.Value)) then
      begin
        imagem := ExtractFilePath(Application.ExeName) +
        '\Imagens\' + DM.qry_pesq_fornecedorforn_img.Value;
      end
      else
      begin
        imagem := ExtractFilePath(Application.ExeName) +
        '\Imagens\nEnc.jpg';
      end;
    end
    else
    begin
      imagem := ExtractFilePath(Application.ExeName) +
      '\Imagens\SemImagem.jpg';
    end;

    img.LoadFromFile(imagem);

    dldt_forn.Append;
    dldt_forn.FieldByName('forn_cod').AsInteger := DM.qry_pesq_fornecedorforn_cod.AsInteger;
    dldt_forn.FieldByName('forn_nome').AsString := DM.qry_pesq_fornecedorforn_nm_fantasia.AsString;
    dldt_forn.FieldByName('forn_data').AsString := dataStr;
    dldt_forn.FieldByName('forn_cnpj').AsString := cnpj_masc;
    dldt_fornforn_img.LoadFromStream(img);
    dldt_forn.Post;
    ds_pesq_forn.DataSet.Next;
  end;

  img.Free;
  frxRpForn.ShowReport();

end;

procedure Tfrm_pesq_fornecedor_c.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.qry_pesq_fornecedor.Close;
  DM.qry_pesq_fornecedor.SQL.Clear;
  DM.qry_pesq_fornecedor.SQL.Add(sqlPadrao);
  qryTelefones.Close;
end;

procedure Tfrm_pesq_fornecedor_c.FormShow(Sender: TObject);
begin
  campoPesq := 'WHERE forn_nm_fantasia like :pPesquisa';
  situacao := ' ';
  ordenacao := 'ORDER BY forn_nm_fantasia ASC';
  edt_pesquisa.SetFocus;
  qryTelefones.Open;
end;

procedure Tfrm_pesq_fornecedor_c.rbt_ambosClick(Sender: TObject);
begin
  situacao := ' ';
end;

procedure Tfrm_pesq_fornecedor_c.rbt_ativoClick(Sender: TObject);
begin
  situacao := ' AND forn_ativo = 1 ';
end;

procedure Tfrm_pesq_fornecedor_c.rbt_azClick(Sender: TObject);
begin
  ordenacao := 'ORDER BY forn_nm_fantasia ASC';
end;

procedure Tfrm_pesq_fornecedor_c.rbt_cnpjClick(Sender: TObject);
begin
  campoPesq := 'WHERE forn_cnpj = :pPesquisa';
  edt_pesquisa.Clear;
  edt_pesquisa.SetFocus;
end;

procedure Tfrm_pesq_fornecedor_c.rbt_dtClick(Sender: TObject);
begin
  campoPesq := 'WHERE forn_dt_cad like :pPesquisa';
  edt_pesquisa.Clear;
  edt_pesquisa.SetFocus;
end;

procedure Tfrm_pesq_fornecedor_c.rbt_inativoClick(Sender: TObject);
begin
  situacao := ' AND forn_ativo = 0 ';
end;

procedure Tfrm_pesq_fornecedor_c.rbt_nm_fantClick(Sender: TObject);
begin
  campoPesq := 'WHERE forn_nm_fantasia like :pPesquisa';
  edt_pesquisa.Clear;
  edt_pesquisa.SetFocus;
end;

procedure Tfrm_pesq_fornecedor_c.rbt_zaClick(Sender: TObject);
begin
  ordenacao := 'ORDER BY forn_nm_fantasia DESC';
end;

end.

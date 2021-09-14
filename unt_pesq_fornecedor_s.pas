unit unt_pesq_fornecedor_s;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, frxClass, frxDBSet, Datasnap.DBClient;


type
  Tfrm_pesq_fornecedor_s = class(TForm)
    edt_pesquisa: TEdit;
    lbl_nome: TLabel;
    btn_pesquisa: TBitBtn;
    dbg_registros_pesquisados: TDBGrid;
    ds_pesquisa: TDataSource;
    btn_relatorio: TBitBtn;
    frx_db_pesq_forn: TfrxDBDataset;
    frx_rep_rel_for: TfrxReport;
    dados_rel: TClientDataSet;
    dados_relnome: TStringField;
    dados_reldata: TStringField;
    dados_relativo: TStringField;
    frx_db_rel: TfrxDBDataset;
    procedure FormShow(Sender: TObject);
    procedure btn_pesquisaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbg_registros_pesquisadosDblClick(Sender: TObject);
    procedure btn_relatorioClick(Sender: TObject);
  private
    { Private declarations }
    pesquisa : String;
    const sql = 'SELECT forn_cod, forn_nm_fantasia, ' +
                'forn_razao_social, forn_dt_cad, forn_cnpj, ' +
                'forn_ativo, forn_img, forn_observacoes ' +
                'FROM FORNECEDORES ';
  public
    { Public declarations }
  end;

var
  frm_pesq_fornecedor_s: Tfrm_pesq_fornecedor_s;

implementation

{$R *.dfm}

uses UDM;

procedure Tfrm_pesq_fornecedor_s.btn_pesquisaClick(Sender: TObject);
begin
  DM.qry_pesq_fornecedor.Close;
  DM.qry_pesq_fornecedor.SQL.Clear;
  DM.qry_pesq_fornecedor.SQL.Add(sql + pesquisa);
  DM.qry_pesq_fornecedor.Parameters.ParamByName('pNmFant').Value :=
    '%' + edt_pesquisa.Text + '%';
  DM.qry_pesq_fornecedor.Open;
  btn_relatorio.Enabled := True;
end;

procedure Tfrm_pesq_fornecedor_s.btn_relatorioClick(Sender: TObject);
var
  dataStr, ativoStr : String;
  dtString: string;
  dtConvertida: TDateTime;
  separadorData: TFormatSettings;
begin
  ds_pesquisa.DataSet.First;
  dados_rel.EmptyDataSet;
  while not ds_pesquisa.DataSet.Eof do
  begin
    // converter data
    dtString := DM.qry_pesq_fornecedorforn_dt_cad.AsString;
    separadorData.ShortDateFormat := 'yyyy-mm-dd';
    separadorData.DateSeparator := '-';
    dtConvertida := StrToDate(dtString, separadorData);
    dataStr := DateToStr(dtConvertida);

    // converter ativo
    if (DM.qry_pesq_fornecedorforn_ativo.Value = true) then
      ativoStr := 'Sim'
    else
      ativoStr := 'Não';

    dados_rel.Append;
    dados_rel.FieldByName('nome').AsString := DM.qry_pesq_fornecedorforn_nm_fantasia.AsString;
    dados_rel.FieldByName('data').AsString := dataStr;
    dados_rel.FieldByName('ativo').AsString := ativoStr;
    dados_rel.Post;
    ds_pesquisa.DataSet.Next;
  end;

  frx_rep_rel_for.ShowReport();
end;

procedure Tfrm_pesq_fornecedor_s.dbg_registros_pesquisadosDblClick(
  Sender: TObject);
begin
  if not DM.qry_pesq_fornecedor.IsEmpty then
  begin
    DM.qry_cad_fornecedor.Close;
    DM.qry_cad_fornecedor.Parameters.ParamByName('pCodForn').Value :=
      DM.qry_pesq_fornecedorforn_cod.AsInteger;
    DM.qry_cad_fornecedor.Open;
    Close;
  end;
end;

procedure Tfrm_pesq_fornecedor_s.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dados_rel.EmptyDataSet;
  DM.qry_pesq_fornecedor.Close;
  DM.qry_pesq_fornecedor.SQL.Clear;
  DM.qry_pesq_fornecedor.SQL.Add(sql);
end;

procedure Tfrm_pesq_fornecedor_s.FormShow(Sender: TObject);
begin
  pesquisa := 'WHERE forn_nm_fantasia like :pNmFant ' +
              'ORDER BY forn_nm_fantasia ASC';
end;


end.

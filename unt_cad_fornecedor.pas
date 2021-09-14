unit unt_cad_fornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, System.Math, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtDlgs, JPEG;

type
  Tfrm_cad_fornecedor = class(TForm)
    ds_cad_forn_tel: TDataSource;
    pgc_forn: TPageControl;
    tbs_forn: TTabSheet;
    tbs_endereco: TTabSheet;
    tbs_telefones: TTabSheet;
    dbg_telefones: TDBGrid;
    btn_cad_tel: TBitBtn;
    btn_edt_tel: TBitBtn;
    btn_exc_tel: TBitBtn;
    lbl_cod: TLabel;
    lbl_nm_fant: TLabel;
    lbl_rz_soc: TLabel;
    lbl_dt_cad: TLabel;
    lbl_cnpj: TLabel;
    lbl_img: TLabel;
    lbl_obs: TLabel;
    dbt_cod: TDBText;
    img_forn: TImage;
    dbe_nm_fant: TDBEdit;
    dbe_rz_soc: TDBEdit;
    dbe_dt_cad: TDBEdit;
    dbe_cnpj: TDBEdit;
    ckb_ativo: TDBCheckBox;
    dbe_img: TDBEdit;
    dbm_obs: TDBMemo;
    btn_cadastrar: TBitBtn;
    btn_editar: TBitBtn;
    btn_salvar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_excluir: TBitBtn;
    dtp_dt_cad: TDateTimePicker;
    mke_cnpj: TMaskEdit;
    btn_pesquisa: TBitBtn;
    btn_img_forn: TBitBtn;
    ds_cad_forn: TDataSource;
    opd_img_forn: TOpenPictureDialog;
    lbl_cod_end: TLabel;
    ds_endereco: TDataSource;
    lbl_cep: TLabel;
    dbe_cep: TDBEdit;
    lbl_logra: TLabel;
    dbe_logra: TDBEdit;
    lbl_comp: TLabel;
    dbe_comp: TDBEdit;
    lbl_bairro: TLabel;
    dbe_bairro: TDBEdit;
    lbl_localizacao: TLabel;
    dbe_localizacao: TDBEdit;
    lbl_uf: TLabel;
    dbe_uf: TDBEdit;
    lbl_n: TLabel;
    dbe_n: TDBEdit;
    lbl_ref: TLabel;
    dbe_ref: TDBEdit;
    btn_ver_cep: TBitBtn;
    dbt_cod_end: TDBText;
    btn_cad_end: TBitBtn;
    btn_edt_end: TBitBtn;
    btn_slv_end: TBitBtn;
    btn_can_end: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_cadastrarClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure ds_cad_fornStateChange(Sender: TObject);
    procedure dtp_dt_cadChange(Sender: TObject);
    procedure ds_cad_fornDataChange(Sender: TObject; Field: TField);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_pesquisaClick(Sender: TObject);
    procedure ds_cad_forn_telStateChange(Sender: TObject);
    procedure btn_cad_telClick(Sender: TObject);
    procedure btn_edt_telClick(Sender: TObject);
    procedure btn_exc_telClick(Sender: TObject);
    procedure btn_img_fornClick(Sender: TObject);
    procedure ds_enderecoStateChange(Sender: TObject);
    procedure btn_cad_endClick(Sender: TObject);
    procedure btn_edt_endClick(Sender: TObject);
    procedure btn_slv_endClick(Sender: TObject);
    procedure btn_ver_cepClick(Sender: TObject);
    procedure btn_can_endClick(Sender: TObject);
  private
    { Private declarations }
    parametro : String;
    const parametroTel = 'WHERE forn_cod = :pCodForn';
    const sql = 'SELECT forn_cod, forn_nm_fantasia, ' +
                'forn_razao_social, forn_dt_cad, forn_cnpj, ' +
                'forn_ativo, forn_img, forn_observacoes ' +
                'FROM FORNECEDORES ';
    const sqlFornTel = 'SELECT forn_tel_cod, forn_tel_contato, ' +
              'forn_tel_tipo, forn_tel_numero, forn_tel_operadora, ' +
              'forn_cod FROM FORNECEDOR_TELEFONES ';
    const sqlFornEnd = 'SELECT forn_cod, for_end_cep, ' +
              'for_end_logradouro, for_end_complemento, for_end_bairro, ' +
              'for_end_localizacao, for_end_uf, for_end_numero, ' +
              'for_end_referencia FROM FORNECEDOR_ENDERECO ';
    function valida : Boolean;
    function validCNPJ(pCNPJ : string) : Boolean;
  public
    { Public declarations }
  end;

var
  frm_cad_fornecedor: Tfrm_cad_fornecedor;

implementation

{$R *.dfm}

uses UDM, unt_pesq_fornecedor_s, uEndereco, unt_cad_telefone_forn;

procedure Tfrm_cad_fornecedor.btn_cadastrarClick(Sender: TObject);
var
  dtString, dia, mes, ano: string;
begin
  ds_cad_forn.DataSet.Append;
  dtp_dt_cad.Date := Now;
  dia := formatdatetime('dd', dtp_dt_cad.Date);
  mes := formatdatetime('mm', dtp_dt_cad.Date);
  ano := formatdatetime('yyyy', dtp_dt_cad.Date);
  dtString := ano + '-' + mes + '-' + dia;
  dbe_dt_cad.Text := dtString;
  ckb_ativo.Checked := True;
  DM.qry_cad_fornecedorforn_ativo.Value := True;
end;

procedure Tfrm_cad_fornecedor.btn_cad_endClick(Sender: TObject);
begin
  ds_endereco.DataSet.Append;
  DM.qry_cad_forn_enderecoforn_cod.Value := DM.qry_cad_fornecedorforn_cod.AsInteger;
end;

procedure Tfrm_cad_fornecedor.btn_cad_telClick(Sender: TObject);
begin
  ds_cad_forn_tel.DataSet.Append;
  DM.qry_cad_forn_telforn_cod.Value := DM.qry_cad_fornecedorforn_cod.AsInteger;

  frm_cad_telefone_forn := Tfrm_cad_telefone_forn.Create(Self);
  try
    frm_cad_telefone_forn.ShowModal;
  finally
    frm_cad_telefone_forn.Free;
  end;
end;

procedure Tfrm_cad_fornecedor.btn_cancelarClick(Sender: TObject);
begin
  ds_cad_forn.DataSet.Cancel;
end;

procedure Tfrm_cad_fornecedor.btn_can_endClick(Sender: TObject);
begin
  ds_endereco.DataSet.Cancel;
end;

procedure Tfrm_cad_fornecedor.btn_editarClick(Sender: TObject);
begin
  ds_cad_forn.DataSet.Edit;
end;

procedure Tfrm_cad_fornecedor.btn_edt_endClick(Sender: TObject);
begin
  ds_endereco.DataSet.Edit;
end;

procedure Tfrm_cad_fornecedor.btn_edt_telClick(Sender: TObject);
begin
  ds_cad_forn_tel.DataSet.Edit;

  frm_cad_telefone_forn := Tfrm_cad_telefone_forn.Create(Self);
  try
    frm_cad_telefone_forn.ShowModal;
  finally
    frm_cad_telefone_forn.Free;
  end;
end;

procedure Tfrm_cad_fornecedor.btn_excluirClick(Sender: TObject);
begin
  if (
      MessageBox(Application.Handle,
      'A exclusão deste registro o tornará inativo! ' + sLineBreak +
      'Deseja constinuar?', 'Excluir',
      MB_YESNO + MB_ICONQUESTION) = IDYES
      ) then
  begin
    ds_cad_forn.DataSet.Edit;
    DM.qry_cad_fornecedorforn_ativo.Value := False;
    ckb_ativo.Checked := False;
    ds_cad_forn.DataSet.Post;
  end;
end;

procedure Tfrm_cad_fornecedor.btn_exc_telClick(Sender: TObject);
begin
  if (
      MessageBox(Application.Handle,
      'Deseja excluir este registro?', 'Excluir',
      MB_YESNO + MB_ICONQUESTION) = IDYES
      ) then
  begin
    ds_cad_forn_tel.DataSet.Delete;
  end;
end;

procedure Tfrm_cad_fornecedor.btn_img_fornClick(Sender: TObject);
var origem: String;
begin
  if (opd_img_forn.Execute()) then
  begin
    img_forn.Picture.LoadFromFile(opd_img_forn.FileName);
    origem := opd_img_forn.FileName;
    Delete(origem, 1, Length(ExtractFilePath(opd_img_forn.FileName)));
    DM.qry_cad_fornecedorforn_img.Value := origem;
  end;
end;

procedure Tfrm_cad_fornecedor.btn_pesquisaClick(Sender: TObject);
var frm_pesq_fornecedor_s : Tfrm_pesq_fornecedor_s;
begin
  frm_pesq_fornecedor_s := Tfrm_pesq_fornecedor_s.Create(Self);
  try
    frm_pesq_fornecedor_s.ShowModal;
  finally
    frm_pesq_fornecedor_s.Free;
  end;
end;

procedure Tfrm_cad_fornecedor.btn_salvarClick(Sender: TObject);
begin
  if (valida = True) then
  begin
    ds_cad_forn.DataSet.Post;
    Application.MessageBox('Dados gravados com sucesso!', 'Aviso', MB_ICONEXCLAMATION);
  end;
end;

procedure Tfrm_cad_fornecedor.btn_slv_endClick(Sender: TObject);
var
  valida : Boolean;
  mensagem : TStringBuilder;
  tamanhoTexto: String;
begin
  mensagem := TStringBuilder.Create;
  mensagem.Append(
    'Erro ao gravar endereço, ' +
    'verifique o(s) item(s) a seguir:' + sLineBreak
  );
  valida := True;

  if (dbe_cep.Text = '') then
  begin
    mensagem.Append('- O CEP deve ser preenchido' + sLineBreak);
    valida := False;
  end;

  tamanhoTexto := dbe_cep.Text;
  if (tamanhoTexto.Length < 8) then
  begin
    valida := false;
    mensagem.Append('- O CEP deve ter 8 dígitos!' + sLineBreak);
  end;

  if (dbe_logra.Text = '') then
  begin
    mensagem.Append('- O nome do logradouro deve ser preenchido' + sLineBreak);
    valida := False;
  end;

  tamanhoTexto := dbe_logra.Text;
  if (tamanhoTexto.Length < 5) then
  begin
    valida := false;
    mensagem.Append('- O nome do logradouro deve ter no mínimo 5 caracteres!' + sLineBreak);
  end;

  if (dbe_n.Text = '') then
  begin
    mensagem.Append('- O nº do endereço deve ser preenchido' + sLineBreak);
    valida := False;
  end;

  if (dbe_bairro.Text = '') then
  begin
    mensagem.Append('- O nome do bairro deve ser preenchido' + sLineBreak);
    valida := False;
  end;

  tamanhoTexto := dbe_bairro.Text;
  if (tamanhoTexto.Length < 3) then
  begin
    valida := false;
    mensagem.Append('- O nome do bairro deve ter no mínimo 3 caracteres!' + sLineBreak);
  end;

  if (dbe_localizacao.Text = '') then
  begin
    mensagem.Append('- O nome da localização deve ser preenchido' + sLineBreak);
    valida := False;
  end;

  tamanhoTexto := dbe_localizacao.Text;
  if (tamanhoTexto.Length < 3) then
  begin
    valida := false;
    mensagem.Append('- O nome da localizãção deve ter no mínimo 3 caracteres!' + sLineBreak);
  end;

  if (dbe_uf.Text = '') then
  begin
    mensagem.Append('- A sigla da UF deve ser preenchida' + sLineBreak);
    valida := False;
  end;

  tamanhoTexto := dbe_uf.Text;
  if (tamanhoTexto.Length <> 2) then
  begin
    valida := false;
    mensagem.Append('- A sigla da UF deve ter 2 caracteres!' + sLineBreak);
  end;

  if (valida = true) then
  begin
    ds_endereco.DataSet.Post;
  end
  else
  begin
    Application.MessageBox(pChar(mensagem.ToString), 'Erro', MB_ICONERROR);
  end;

end;

procedure Tfrm_cad_fornecedor.btn_ver_cepClick(Sender: TObject);
var _rEndereco: TEndereco;
begin
  if dbe_cep.Text = EmptyStr then
    Exit;
  _rEndereco := TEndereco.Create(dbe_cep.Text);
  try
    dbe_logra.Text := _rEndereco.Logradouro;
    dbe_bairro.Text := _rEndereco.Bairro;
    dbe_localizacao.Text := _rEndereco.Cidade;
    dbe_uf.Text := _rEndereco.UF;
  finally
    _rEndereco.Free;
  end;
end;

procedure Tfrm_cad_fornecedor.ds_cad_fornDataChange(Sender: TObject;
  Field: TField);
var
  dtString: string;
  dtConvertida: TDateTime;
  separadorData: TFormatSettings;
begin
  if ((ds_cad_forn.State = dsBrowse) and (not ds_cad_forn.DataSet.IsEmpty)) then
  begin
    dtString := dbe_dt_cad.Text;
    separadorData.ShortDateFormat := 'yyyy-mm-dd';
    separadorData.DateSeparator := '-';
    dtConvertida := StrToDate(dtString, separadorData);
    dtp_dt_cad.Date := dtConvertida;
    mke_cnpj.Text := dbe_cnpj.Text;

    DM.qry_cad_forn_tel.Close;
    DM.qry_cad_forn_tel.Parameters.ParamByName('pCodForn').Value := DM.qry_cad_fornecedorforn_cod.AsInteger;
    DM.qry_cad_forn_tel.Open;

    if (DM.qry_cad_fornecedorforn_img.Value <> '') then
    begin
      if (FileExists(ExtractFilePath(Application.ExeName) +
          '\Imagens\' + DM.qry_cad_fornecedorforn_img.Value)) then
      begin
        img_forn.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
        '\Imagens\' + DM.qry_cad_fornecedorforn_img.Value);
      end
      else
      begin
        img_forn.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
        '\Imagens\nEnc.jpg');
      end;
    end
    else
    begin
      img_forn.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
      '\Imagens\SemImagem.jpg');
    end;

    DM.qry_cad_forn_endereco.Close;
    DM.qry_cad_forn_endereco.Parameters.ParamByName('pCodForn').Value := DM.qry_cad_fornecedorforn_cod.AsInteger;
    DM.qry_cad_forn_endereco.Open;

  end;

  if (DM.qry_cad_fornecedor.IsEmpty) then
  begin
    btn_editar.Enabled := False;
    btn_excluir.Enabled := False;
    btn_cad_tel.Enabled := False;
    btn_edt_tel.Enabled := False;
    btn_exc_tel.Enabled := False;
    btn_cad_end.Enabled := False;
    btn_edt_end.Enabled := False;
    btn_slv_end.Enabled := False;
    btn_can_end.Enabled := False;
    btn_ver_cep.Enabled := False;
  end;

end;

procedure Tfrm_cad_fornecedor.ds_cad_fornStateChange(Sender: TObject);
begin
  btn_cadastrar.Enabled := ds_cad_forn.State = dsBrowse;
  btn_editar.Enabled := ds_cad_forn.State = dsBrowse;
  btn_excluir.Enabled := ds_cad_forn.State = dsBrowse;
  btn_salvar.Enabled := ds_cad_forn.State in [dsInsert, dsEdit];
  btn_cancelar.Enabled := ds_cad_forn.State in [dsInsert, dsEdit];
  dtp_dt_cad.Enabled := ds_cad_forn.State in [dsInsert, dsEdit];
  mke_cnpj.Visible := ds_cad_forn.State = dsBrowse;
  dbe_cnpj.Visible := ds_cad_forn.State in [dsInsert, dsEdit];
  btn_img_forn.Enabled := ds_cad_forn.State in [dsInsert, dsEdit];
end;

procedure Tfrm_cad_fornecedor.ds_cad_forn_telStateChange(Sender: TObject);
begin
  btn_cad_tel.Enabled := ds_cad_forn_tel.State = dsBrowse;
  btn_edt_tel.Enabled := ds_cad_forn_tel.State = dsBrowse;
  btn_exc_tel.Enabled := ds_cad_forn_tel.State = dsBrowse;
end;

procedure Tfrm_cad_fornecedor.ds_enderecoStateChange(Sender: TObject);
begin
  btn_cad_end.Enabled := ds_endereco.State = dsBrowse;
  btn_edt_end.Enabled := ds_endereco.State = dsBrowse;
  btn_slv_end.Enabled := ds_endereco.State in [dsInsert, dsEdit];
  btn_can_end.Enabled := ds_endereco.State in [dsInsert, dsEdit];
  btn_ver_cep.Enabled := ds_endereco.State in [dsInsert, dsEdit];
end;

procedure Tfrm_cad_fornecedor.dtp_dt_cadChange(Sender: TObject);
var
  dtString, dia, mes, ano: string;
begin
  dia := formatdatetime('dd', dtp_dt_cad.Date);
  mes := formatdatetime('mm', dtp_dt_cad.Date);
  ano := formatdatetime('yyyy', dtp_dt_cad.Date);

  dtString := ano + '-' + mes + '-' + dia;
  dbe_dt_cad.Text := dtString;
end;

procedure Tfrm_cad_fornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.qry_cad_forn_tel.Close;
  DM.qry_cad_forn_tel.SQL.Clear;
  DM.qry_cad_forn_tel.SQL.Add(sqlFornTel);

  DM.qry_cad_forn_endereco.Close;
  DM.qry_cad_forn_endereco.SQL.Clear;
  DM.qry_cad_forn_endereco.SQL.Add(sqlFornEnd);

  DM.qry_cad_fornecedor.Close;
  DM.qry_cad_fornecedor.SQL.Clear;
  DM.qry_cad_fornecedor.SQL.Add(sql);

end;

procedure Tfrm_cad_fornecedor.FormShow(Sender: TObject);
begin

  parametro := 'WHERE forn_cod = :pCodForn';
  DM.qry_cad_fornecedor.Close;
  DM.qry_cad_fornecedor.SQL.Clear;
  DM.qry_cad_fornecedor.SQL.Add(sql + parametro);
  DM.qry_cad_fornecedor.Open;

  DM.qry_cad_forn_tel.Close;
  DM.qry_cad_forn_tel.SQL.Clear;
  DM.qry_cad_forn_tel.SQL.Add(sqlFornTel + parametroTel);

  DM.qry_cad_forn_endereco.Close;
  DM.qry_cad_forn_endereco.SQL.Clear;
  DM.qry_cad_forn_endereco.SQL.Add(sqlFornEnd + parametro);

end;

function Tfrm_cad_fornecedor.valida: Boolean;
var
  mensagem : TStringBuilder;
  valida : Boolean;
  tamanhoTexto : String;
begin
  mensagem := TStringBuilder.Create;
  mensagem.Append(
    'Erro ao gravar dados, ' +
    'verifique o(s) item(s) a seguir:' + sLineBreak
  );
  valida := True;

  // Campo não preenchido
  if (dbe_nm_fant.Text = '') then
  begin
    valida := false;
    mensagem.Append('- Preencha o nome fantasia.' + sLineBreak);
  end;
  if (dbe_rz_soc.Text = '') then
  begin
    valida := false;
    mensagem.Append('- Preencha a razão social.' + sLineBreak);
  end;

  // Campo com menor número de caracteres
  tamanhoTexto := dbe_nm_fant.Text;
  if (tamanhoTexto.Length < 4) then
  begin
    valida := false;
    mensagem.Append('- O nome fantasia deve ter pelo menos 3 caracteres.' + sLineBreak);
  end;
  tamanhoTexto := dbe_rz_soc.Text;
  if (tamanhoTexto.Length < 6) then
  begin
    valida := false;
    mensagem.Append('- A razão social deve ter pelo menos 5 caracteres.' + sLineBreak);
  end;

  // Validação de CNPJ
  if not (validCNPJ(dbe_cnpj.Text)) then
  begin
    valida := false;
    mensagem.Append('- Insira um CNPJ válido' + sLineBreak);
  end;

  // Mensagem de erro
  if (valida = False) then
  begin
    Application.MessageBox(pChar(mensagem.ToString), 'Erro', MB_ICONERROR);
  end;

  Result := valida;
  FreeAndNil(mensagem);
end;

function Tfrm_cad_fornecedor.validCNPJ(pCNPJ: string): Boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(pCNPJ) <> 14 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if pCNPJ = StringOfChar('0', 14) then
    Exit;

  if pCNPJ = StringOfChar('1', 14) then
    Exit;

  if pCNPJ = StringOfChar('2', 14) then
    Exit;

  if pCNPJ = StringOfChar('3', 14) then
    Exit;

  if pCNPJ = StringOfChar('4', 14) then
    Exit;

  if pCNPJ = StringOfChar('5', 14) then
    Exit;

  if pCNPJ = StringOfChar('6', 14) then
    Exit;

  if pCNPJ = StringOfChar('7', 14) then
    Exit;

  if pCNPJ = StringOfChar('8', 14) then
    Exit;

  if pCNPJ = StringOfChar('9', 14) then
    Exit;

  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(pCNPJ[i]);

    //Nota: Calcula o primeiro dígito de verificação.
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    //Nota: Calcula o segundo dígito de verificação.
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);

    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except on E: Exception do
    Result := False;
  end;

end;

end.



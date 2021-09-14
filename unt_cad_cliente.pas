unit unt_cad_cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls, UDM, StrUtils, System.DateUtils;

type
  Tfrm_cad_cliente = class(TForm)
    lbl_cod: TLabel;
    ds_cad_cli: TDataSource;
    lbl_nome: TLabel;
    dbe_nome: TDBEdit;
    lbl_cpf: TLabel;
    dbe_cpf: TDBEdit;
    lbl_renda: TLabel;
    dbe_renda: TDBEdit;
    ckb_ativo: TDBCheckBox;
    lbl_nascimento: TLabel;
    lbl_imagem: TLabel;
    dbe_imagem: TDBEdit;
    lbl_email: TLabel;
    dbe_email: TDBEdit;
    dbt_cod: TDBText;
    btn_cadastrar: TBitBtn;
    btn_editar: TBitBtn;
    btn_salvar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_excluir: TBitBtn;
    dtp_cli: TDateTimePicker;
    mke_cpf: TMaskEdit;
    btn_pesq_cliente: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_cadastrarClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure ds_cad_cliStateChange(Sender: TObject);
    procedure dtp_cliChange(Sender: TObject);
    procedure ds_cad_cliDataChange(Sender: TObject; Field: TField);
    procedure Button1Click(Sender: TObject);
    procedure btn_pesq_clienteClick(Sender: TObject);
  private
    { Private declarations }
    const sqlCli = 'SELECT cli_cod, cli_nome, cli_cpf, cli_renda, cli_ativo, cli_dt_nasc, cli_img, cli_email FROM CLIENTES ';
    function Valida : Boolean;
    function ValidarCPF(numCPF: string): Boolean;
  public
    { Public declarations }
  end;

var
  frm_cad_cliente: Tfrm_cad_cliente;

implementation

{$R *.dfm}

uses unt_pesq_cliente_s;



procedure Tfrm_cad_cliente.btn_cadastrarClick(Sender: TObject);
begin
  ds_cad_cli.DataSet.Append;
  ckb_ativo.Checked := True;
  DM.qry_cad_clientecli_ativo.Value := True;
end;

procedure Tfrm_cad_cliente.btn_cancelarClick(Sender: TObject);
begin
  ds_cad_cli.DataSet.Cancel;
end;

procedure Tfrm_cad_cliente.btn_editarClick(Sender: TObject);
begin
  ds_cad_cli.DataSet.Edit;
end;

procedure Tfrm_cad_cliente.btn_excluirClick(Sender: TObject);
begin
  if (
      MessageBox(Application.Handle,
      'Deseja excluir este registro?', 'Excluir',
      MB_YESNO + MB_ICONQUESTION) = IDYES
  ) then
  begin
    ds_cad_cli.DataSet.Delete;
  end;

end;

procedure Tfrm_cad_cliente.btn_pesq_clienteClick(Sender: TObject);
begin
  frm_pesq_cliente_s := Tfrm_pesq_cliente_s.Create(Self);
  try
    frm_pesq_cliente_s.ShowModal;
  finally
    frm_pesq_cliente_s.Free;
  end;
end;

procedure Tfrm_cad_cliente.btn_salvarClick(Sender: TObject);
begin
  if (valida = True) then
  begin
    ds_cad_cli.DataSet.Post;
    Application.MessageBox('Dados gravados com sucesso!', 'Aviso', MB_ICONEXCLAMATION);
  end;
end;

procedure Tfrm_cad_cliente.Button1Click(Sender: TObject);
begin
  ShowMessage(mke_cpf.Text);
end;

procedure Tfrm_cad_cliente.dtp_cliChange(Sender: TObject);
var
  dtString, dia, mes, ano: String;
begin
  dia := FormatDateTime('dd', dtp_cli.Date);
  mes := FormatDateTime('mm', dtp_cli.Date);
  ano := FormatDateTime('yyyy', dtp_cli.Date);

  dtString := ano + '-' + mes + '-' + dia;
  DM.qry_cad_clientecli_dt_nasc.Value := dtString;
end;

procedure Tfrm_cad_cliente.ds_cad_cliDataChange(Sender: TObject; Field: TField);
var
  dtString : String;
  dtConvertida: TDateTime;
  separadorData: TFormatSettings;
begin
  if ((ds_cad_cli.State = dsBrowse) and (not ds_cad_cli.DataSet.IsEmpty)) then
  begin
    dtString := DM.qry_cad_clientecli_dt_nasc.AsString;
    separadorData.ShortDateFormat := 'yyyy-mm-dd';
    separadorData.DateSeparator := '-';
    dtConvertida := StrToDate(dtString, separadorData);
    dtp_cli.Date := dtConvertida;
    mke_cpf.Text :=  DM.qry_cad_clientecli_cpf.AsString;
  end;
end;

procedure Tfrm_cad_cliente.ds_cad_cliStateChange(Sender: TObject);
begin
  btn_cadastrar.Enabled := ds_cad_cli.State = dsBrowse;
  btn_editar.Enabled := ds_cad_cli.State = dsBrowse;
  btn_excluir.Enabled := ds_cad_cli.State = dsBrowse;
  btn_salvar.Enabled := ds_cad_cli.State in [dsInsert, dsEdit];
  btn_cancelar.Enabled := ds_cad_cli.State in [dsInsert, dsEdit];
  dtp_cli.Enabled := ds_cad_cli.State in [dsInsert, dsEdit];
  mke_cpf.Visible := ds_cad_cli.State = dsBrowse;
  dbe_cpf.Visible := ds_cad_cli.State in [dsInsert, dsEdit];
end;

procedure Tfrm_cad_cliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.qry_cad_cliente.Close;
  DM.qry_cad_cliente.SQL.Clear;
  DM.qry_cad_cliente.SQL.Add(sqlCli);
end;

procedure Tfrm_cad_cliente.FormShow(Sender: TObject);
begin
  DM.qry_cad_cliente.Close;
  DM.qry_cad_cliente.SQL.Clear;
  DM.qry_cad_cliente.SQL.Add(sqlCli + 'Where cli_cod = :pCodCli');
  DM.qry_cad_cliente.Open;
end;

function Tfrm_cad_cliente.valida: Boolean;
var
  mensagem: TStringBuilder;
  valida : Boolean;
begin
  mensagem := TStringBuilder.Create;
  mensagem.Append(
    'Erro ao gravar dados, verifique o(s) item(ns) a seguir: ' + sLineBreak
  );

  valida := True;

  if (DM.qry_cad_clientecli_nome.Value = '') then
  begin
    valida := False;
    mensagem.Append('- Preencha o nome fantasia.' + sLineBreak);
    dbe_nome.SetFocus;
  end;
  if (DM.qry_cad_clientecli_email.Value = '') then
  begin
    valida := False;
    mensagem.Append('- Preencha o e-mail.' + sLineBreak);
    dbe_email.SetFocus;
  end;
  if (DM.qry_cad_clientecli_dt_nasc.Value = '') then
  begin
    valida := False;
    mensagem.Append('- Escolha a data de nascimento no calendário.' + sLineBreak);
    dtp_cli.SetFocus;
  end;
  if (YearsBetween(date, dtp_cli.Date) < 18) then
  begin
    valida := False;
    mensagem.Append('- O cliente não pode ter menos de 18 anos!' + sLineBreak);
    dtp_cli.SetFocus;
  end;
  if (ValidarCPF(DM.qry_cad_clientecli_cpf.Value) = False) then
  begin
    valida := False;
    mensagem.Append('- CPF inválido.' + sLineBreak);
    dbe_cpf.SetFocus;
  end;
  if (dbe_renda.Text = '') then
  begin
    valida := False;
    mensagem.Append('- Insira o valor da renda do cliente.' + sLineBreak);
    dbe_nome.SetFocus;
  end;
  if (DM.qry_cad_clientecli_renda.Value < 100.00) then
  begin
    valida := False;
    mensagem.Append('- O valor da renda deve ser maior que R$ 100,00.' + sLineBreak);
    dbe_nome.SetFocus;
  end;

  if (valida = False) then
  begin
    Application.MessageBox(pChar(mensagem.ToString), 'Erro', MB_ICONERROR);
  end;

  FreeAndNil(mensagem);
  Result := valida;
end;

function Tfrm_cad_cliente.ValidarCPF(numCPF: string): Boolean;
var
   cpf: string;
   x, total, dg1, dg2: Integer;
   ret: boolean;
begin
  ret := True;
  for x := 1 to Length(numCPF) do
     if not (numCPF[x] in ['0'..'9', '-', '.', ' ']) then
        ret := False;
  if ret then
   begin
     ret := True;
     cpf := '';
     for x := 1 to Length(numCPF) do
        if numCPF[x] in ['0'..'9'] then
           cpf := cpf + numCPF[x];
     if Length(cpf) <> 11 then
        ret := False;
     if ret then
      begin
        //1° dígito
        total := 0;
        for x := 1 to 9 do
         total := total + (StrToInt(cpf[x]) * x);
        dg1 := total mod 11;
        if dg1 = 10 then
           dg1 := 0;
        //2° dígito
        total := 0;
        for x := 1 to 8 do
           total := total + (StrToInt(cpf[x + 1]) * (x));
        total := total + (dg1 * 9);
        dg2 := total mod 11;
        if dg2 = 10 then
           dg2 := 0;
        //Validação final
      if (dg1 = StrToInt(cpf[10])) and (dg2 = StrToInt(cpf[11])) then
        ret := True
      else
        ret := False;
        //Inválidos
      case AnsiIndexStr(cpf,['00000000000','11111111111','22222222222','33333333333','44444444444',
       '55555555555','66666666666','77777777777','88888888888','99999999999']) of
         0..9: ret := False;
         end;
      end
     else
    begin
        //Se não informado deixa passar
        if cpf = '' then
           ret := True;
    end;
   end;
  result := ret;
end;

end.

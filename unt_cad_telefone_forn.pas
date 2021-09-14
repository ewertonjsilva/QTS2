unit unt_cad_telefone_forn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.DBCtrls, Data.DB;

type
  Tfrm_cad_telefone_forn = class(TForm)
    ds_cad_tel_forn: TDataSource;
    lbl_contato: TLabel;
    lbl_tipo: TLabel;
    btn_num: TLabel;
    lbl_operadora: TLabel;
    dbe_contato: TDBEdit;
    dbc_tipo: TDBComboBox;
    dbc_operadora: TDBComboBox;
    msk_num: TMaskEdit;
    btn_gravar: TBitBtn;
    btn_cancelar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure dbc_tipoChange(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
  private
    tipo : Boolean;
  public
    { Public declarations }
  end;

var
  frm_cad_telefone_forn: Tfrm_cad_telefone_forn;

implementation

{$R *.dfm}

uses UDM;

procedure Tfrm_cad_telefone_forn.btn_cancelarClick(Sender: TObject);
begin
  ds_cad_tel_forn.DataSet.Cancel;
  Close;
end;

procedure Tfrm_cad_telefone_forn.btn_gravarClick(Sender: TObject);
var
  valida : Boolean;
  mensagem : TStringBuilder;
  tamanho : String;
begin
  mensagem := TStringBuilder.Create;
  mensagem.Append(
    'Erro ao gravar dados, ' +
    'verifique o(s) item(s) a seguir:' + sLineBreak
  );
  valida := True;

  if (DM.qry_cad_forn_telforn_tel_contato.Value = '') then
  begin
    mensagem.Append('- O nome do contato não pode ficar em branco' + sLineBreak);
    valida := False;
  end;
  if (dbc_tipo.ItemIndex = -1) then
  begin
    mensagem.Append('- O tipo do telefone deve ser inserido' + sLineBreak);
    valida := False;
  end;
  tamanho := msk_num.Text;
  if ((tipo = true) and (tamanho.Length < 13)) then
  begin
    mensagem.Append('- O número do telefone deve estar completo' + sLineBreak);
    valida := False;
  end;
  if ((tipo = false) and (tamanho.Length < 14)) then
  begin
    mensagem.Append('- O número do telefone deve estar completo' + sLineBreak);
    valida := False;
  end;
  if (dbc_operadora.ItemIndex = -1) then
  begin
    mensagem.Append('- A operadora deve ser inserida' + sLineBreak);
    valida := False;
  end;

  if (valida = true) then
  begin
    DM.qry_cad_forn_telforn_tel_numero.Value := msk_num.Text;
    ds_cad_tel_forn.DataSet.Post;
    Close;
  end
  else
  begin
    Application.MessageBox(pChar(mensagem.ToString), 'Erro', MB_ICONERROR);
  end;
end;

procedure Tfrm_cad_telefone_forn.dbc_tipoChange(Sender: TObject);
begin

  msk_num.Text := '';

  if (
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Fixo') or
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Fixo Recado') or
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Fax')
      ) then
  begin
    msk_num.EditMask := '\(00\)0000\-0000;1;_';
    tipo := True;
  end;
  if (
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Celular') or
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Celular Recado')
      ) then
  begin
    msk_num.EditMask := '\(00\)\90000\-0000;1;_';
    tipo := False;
  end;
  msk_num.Enabled := True;
end;

procedure Tfrm_cad_telefone_forn.FormShow(Sender: TObject);
begin
  msk_num.Text := DM.qry_cad_forn_telforn_tel_numero.AsString;
  msk_num.Enabled := False;

  if (
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Fixo') or
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Fixo Recado') or
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Fax')
      ) then
  begin
    tipo := True;
    msk_num.Enabled := True;
  end;
  if (
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Celular') or
        (dbc_tipo.Items[dbc_tipo.ItemIndex] = 'Celular Recado')
      ) then
  begin
    tipo := False;
    msk_num.Enabled := True;
  end;
end;

end.

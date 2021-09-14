unit unt_pesq_cliente_s;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons;

type
  Tfrm_pesq_cliente_s = class(TForm)
    lbl_nome: TLabel;
    edt_pesquisa: TEdit;
    btn_pesquisar: TBitBtn;
    btn_relatorio: TBitBtn;
    dbg_clientes: TDBGrid;
    ds_pesquisa: TDataSource;
    procedure btn_pesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbg_clientesDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    const sqlPesqCli = 'SELECT cli_cod, cli_nome, cli_cpf, cli_renda, cli_ativo, cli_dt_nasc, cli_img, cli_email FROM CLIENTES ';
  public
    { Public declarations }
  end;

var
  frm_pesq_cliente_s: Tfrm_pesq_cliente_s;

implementation

{$R *.dfm}

uses UDM;

procedure Tfrm_pesq_cliente_s.btn_pesquisarClick(Sender: TObject);
begin
  DM.qry_pesq_cliente.Close;
  DM.qry_pesq_cliente.Parameters.ParamByName('pNome').Value := '%' + edt_pesquisa.Text + '%';
  DM.qry_pesq_cliente.Open;
end;

procedure Tfrm_pesq_cliente_s.dbg_clientesDblClick(Sender: TObject);
begin

  if ( (not DM.qry_pesq_cliente.IsEmpty) and (frm_pesq_cliente_s.Tag = 0)) then
  begin
    DM.qry_cad_cliente.Close;
    DM.qry_cad_cliente.Parameters.ParamByName('pCodCli').Value :=  DM.qry_pesq_clientecli_cod.AsInteger;
    DM.qry_cad_cliente.Open;
    Close;
  end;

  if ((not DM.qry_pesq_cliente.IsEmpty) and (frm_pesq_cliente_s.Tag = 2)) then
  begin
    DM.qry_cad_vendacli_cod.Value := DM.qry_pesq_clientecli_cod.AsInteger;
    Close;
  end;
end;

procedure Tfrm_pesq_cliente_s.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.qry_pesq_cliente.Close;
  DM.qry_pesq_cliente.SQL.Clear;
  DM.qry_pesq_cliente.SQL.Add(sqlPesqCli);
end;

procedure Tfrm_pesq_cliente_s.FormShow(Sender: TObject);
begin
  DM.qry_pesq_cliente.Close;
  DM.qry_pesq_cliente.SQL.Clear;
  DM.qry_pesq_cliente.SQL.Add(sqlPesqCli + 'WHERE cli_nome like :pNome');
end;

end.

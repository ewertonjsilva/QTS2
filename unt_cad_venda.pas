unit unt_cad_venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  Tfrm_cad_venda = class(TForm)
    pnl_vnd: TPanel;
    pnl_btn_vld: TPanel;
    pnl_vnd_prod: TPanel;
    pnl_btn_vnd_prod: TPanel;
    lvl_cod_vnd: TLabel;
    ds_cad_venda: TDataSource;
    lbl_cod_cli: TLabel;
    dbe_cliente: TDBEdit;
    lbl_cod_func: TLabel;
    dbe_funcionario: TDBEdit;
    lbl_dt_vnd: TLabel;
    dbe_data_vnd: TDBEdit;
    dbt_cod_vnd: TDBText;
    btn_add_vnd: TBitBtn;
    btn_edt_venda: TBitBtn;
    btn_svl_vnd: TBitBtn;
    btn_exc_venda: TBitBtn;
    btn_canc_venda: TBitBtn;
    btn_imprimir: TBitBtn;
    btn_email: TBitBtn;
    dbg_vnd_prod: TDBGrid;
    btn_add_prod: TBitBtn;
    btn_edt_prod: TBitBtn;
    btn_exc_prod: TBitBtn;
    lbl_txt_total_vnd: TLabel;
    lbl_valor_total_vnd: TLabel;
    ds_vnd_prod: TDataSource;
    DBNavigator1: TDBNavigator;
    dbt_cliente: TDBText;
    ds_cliente: TDataSource;
    dbl_funcionario: TDBLookupComboBox;
    ds_funcionario: TDataSource;
    btn_cliente: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ds_cad_vendaDataChange(Sender: TObject; Field: TField);
    procedure ds_cad_vendaStateChange(Sender: TObject);
    procedure btn_add_vndClick(Sender: TObject);
    procedure btn_edt_vendaClick(Sender: TObject);
    procedure btn_svl_vndClick(Sender: TObject);
    procedure btn_exc_vendaClick(Sender: TObject);
    procedure btn_canc_vendaClick(Sender: TObject);
    procedure btn_add_prodClick(Sender: TObject);
    procedure btn_edt_prodClick(Sender: TObject);
    procedure btn_exc_prodClick(Sender: TObject);
    procedure btn_clienteClick(Sender: TObject);
  private
    { Private declarations }
    procedure incrementaEstoque;
    const sqlVndProd = 'SELECT vnd_cod, prod_cod, vnd_prod_qtd, vnd_prod_valor FROM VENDA_PRODUTOS ';
    const sqlCadProd = 'SELECT prod_cod, prod_nome, prod_img, prod_estq, prod_vlr_comp, prod_vlr_vnd, prod_lucro FROM PRODUTOS ';
    const sqlCadCli = 'SELECT cli_cod, cli_nome, cli_cpf, cli_renda, cli_ativo, cli_dt_nasc, cli_img, cli_email FROM CLIENTES ';
  public
    { Public declarations }
  end;

var
  frm_cad_venda: Tfrm_cad_venda;

implementation

{$R *.dfm}

uses UDM, unt_cad_produto_venda, unt_pesq_cliente_s;

procedure Tfrm_cad_venda.btn_add_prodClick(Sender: TObject);
begin
  frm_cad_produto_venda := Tfrm_cad_produto_venda.Create(Self);
  try
    frm_cad_produto_venda.ShowModal;
  finally
    frm_cad_produto_venda.Free;
  end;
end;

procedure Tfrm_cad_venda.btn_add_vndClick(Sender: TObject);
begin
  ds_cad_venda.DataSet.Append;
end;

procedure Tfrm_cad_venda.btn_canc_vendaClick(Sender: TObject);
begin
  ds_cad_venda.DataSet.Cancel;
end;

procedure Tfrm_cad_venda.btn_clienteClick(Sender: TObject);
begin
  frm_pesq_cliente_s := Tfrm_pesq_cliente_s.Create(Self);
  try
    frm_pesq_cliente_s.Tag := 2;
    frm_pesq_cliente_s.ShowModal;
  finally
    frm_pesq_cliente_s.Free;
  end;
end;

procedure Tfrm_cad_venda.btn_edt_prodClick(Sender: TObject);
begin
  if not (DM.qry_lista_vnd_prod.IsEmpty) then
  begin
    incrementaEstoque;

    frm_cad_produto_venda := Tfrm_cad_produto_venda.Create(Self);
    try
      frm_cad_produto_venda.Tag := 1;
      frm_cad_produto_venda.ShowModal;
    finally
      frm_cad_produto_venda.Free;
    end;
  end;
end;

procedure Tfrm_cad_venda.btn_edt_vendaClick(Sender: TObject);
begin
  ds_cad_venda.DataSet.Edit;
end;

procedure Tfrm_cad_venda.btn_exc_prodClick(Sender: TObject);
begin
  if not (DM.qry_lista_vnd_prod.IsEmpty) then
  begin
    incrementaEstoque;
    ds_vnd_prod.DataSet.Delete;
  end;
end;

procedure Tfrm_cad_venda.btn_exc_vendaClick(Sender: TObject);
begin
  if (ds_vnd_prod.DataSet.IsEmpty) then
  begin
    if (
        MessageBox(Application.Handle,
        'Deseja excluir a venda?', 'Excluir',
        MB_YESNO + MB_ICONQUESTION) = IDYES
        ) then
    begin
      ds_cad_venda.DataSet.Delete;
    end;
  end
  else
  begin
    Application.MessageBox('Para excluir uma venda é necessário primeiro excluir os produtos!', 'Erro', MB_ICONERROR);
  end;
end;

procedure Tfrm_cad_venda.btn_svl_vndClick(Sender: TObject);
var
  mensagem : TStringBuilder;
  valida : Boolean;
begin
  mensagem := TStringBuilder.Create;
  mensagem.Append(
    'Erro ao gravar dados, ' +
    'verifique o(s) item(s) a seguir:' + sLineBreak
  );
  valida := True;

  if (dbe_data_vnd.Text = '') then
  begin
    valida := false;
    mensagem.Append('- Insira a data de cadastro da venda.' + sLineBreak);
  end;
  if (dbe_cliente.Text = '') then
  begin
    valida := false;
    mensagem.Append('- Insira o código do cliente.' + sLineBreak);
  end;
  if (dbe_funcionario.Text = '') then
  begin
    valida := false;
    mensagem.Append('- Insira o código do funcionário.' + sLineBreak);
  end;

  // Mensagem de erro
  if (valida = False) then
  begin
    Application.MessageBox(pChar(mensagem.ToString), 'Erro', MB_ICONERROR);
  end
  else
  begin
    ds_cad_venda.DataSet.Post;
  end;

  FreeAndNil(mensagem);

end;

procedure Tfrm_cad_venda.ds_cad_vendaDataChange(Sender: TObject; Field: TField);
begin
  if (not ds_cad_venda.DataSet.IsEmpty) then
  begin
    DM.qry_lista_vnd_prod.Close;
    DM.qry_lista_vnd_prod.Parameters.ParamByName('pCodVnd').Value := DM.qry_cad_vendavnd_cod.AsInteger;
    DM.qry_lista_vnd_prod.Fields.Clear;
    DM.qry_lista_vnd_prod.Open;


    //dbg_vnd_prod.DataSource := ds_vnd_prod;
    dbg_vnd_prod.Columns.Clear;
    dbg_vnd_prod.Columns.RebuildColumns;

    dbg_vnd_prod.Columns[0].Title.Caption := 'Produto';
    dbg_vnd_prod.Columns[0].Width := 450;
    dbg_vnd_prod.Columns[1].Title.Caption := 'Quantidade';
    dbg_vnd_prod.Columns[1].Width := 150;
    dbg_vnd_prod.Columns[2].Title.Caption := 'Valor';
    dbg_vnd_prod.Columns[2].Width := 150;
    dbg_vnd_prod.Columns[3].Title.Caption := 'Subtotal';
    dbg_vnd_prod.Columns[3].Width := 150;

    DM.qry_pesq_cliente.Close;
    DM.qry_pesq_cliente.SQL.Clear;
    DM.qry_pesq_cliente.SQL.Add(sqlCadCli + 'WHERE cli_cod = :pCodigo');
    DM.qry_pesq_cliente.Parameters.ParamByName('pCodigo').Value := DM.qry_cad_vendacli_cod.AsInteger;
    DM.qry_pesq_cliente.Open;

    DM.qry_total.Close;
    DM.qry_total.Parameters.ParamByName('pCodVnd').Value := DM.qry_cad_vendavnd_cod.AsInteger;
    DM.qry_total.Open;
    lbl_valor_total_vnd.Caption := FormatFloat('0.00', DM.qry_total.Fields[0].AsFloat);
  end;
end;

procedure Tfrm_cad_venda.ds_cad_vendaStateChange(Sender: TObject);
begin
  btn_add_vnd.Enabled := ds_cad_venda.State = dsBrowse;
  btn_edt_venda.Enabled := ds_cad_venda.State = dsBrowse;
  btn_exc_venda.Enabled := ds_cad_venda.State = dsBrowse;
  btn_imprimir.Enabled := ds_cad_venda.State = dsBrowse;
  btn_email.Enabled := ds_cad_venda.State = dsBrowse;
  btn_add_prod.Enabled := ds_cad_venda.State = dsBrowse;
  btn_edt_prod.Enabled := ds_cad_venda.State = dsBrowse;
  btn_exc_prod.Enabled := ds_cad_venda.State = dsBrowse;
  btn_svl_vnd.Enabled := ds_cad_venda.State in [dsInsert, dsEdit];
  btn_canc_venda.Enabled := ds_cad_venda.State in [dsInsert, dsEdit];
  dbl_funcionario.Enabled := ds_cad_venda.State in [dsInsert, dsEdit];
  btn_cliente.Enabled := ds_cad_venda.State in [dsInsert, dsEdit];
end;

procedure Tfrm_cad_venda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.qry_lista_vnd_prod.Close;
  DM.qry_lista_vnd_prod.SQL.Add(sqlVndProd);
  DM.qry_cad_venda.Close;
  DM.qry_total.Close;

  DM.qry_pesq_cliente.Close;
  DM.qry_pesq_cliente.SQL.Add(sqlCadCli);

  DM.qry_pesq_funcionario.Close;
end;

procedure Tfrm_cad_venda.FormShow(Sender: TObject);
begin
  DM.qry_lista_vnd_prod.Close;
  DM.qry_lista_vnd_prod.SQL.Clear;
  DM.qry_lista_vnd_prod.SQL.Add('SELECT ');
  DM.qry_lista_vnd_prod.SQL.Add('pd.prod_nome, vp.vnd_prod_qtd, vp.vnd_prod_valor, (vp.vnd_prod_qtd * vp.vnd_prod_valor) AS subtotal ');
  DM.qry_lista_vnd_prod.SQL.Add('FROM VENDA_PRODUTOS vp ');
  DM.qry_lista_vnd_prod.SQL.Add('INNER JOIN PRODUTOS pd ');
  DM.qry_lista_vnd_prod.SQL.Add('ON vp.prod_cod = pd.prod_cod ');
  DM.qry_lista_vnd_prod.SQL.Add('WHERE vp.vnd_cod = :pCodVnd');

  DM.qry_total.Close;
  DM.qry_total.SQL.Clear;
  DM.qry_total.SQL.Add('SELECT SUM(vnd_prod_qtd * vnd_prod_valor) AS total ');
  DM.qry_total.SQL.Add('FROM VENDA_PRODUTOS ');
  DM.qry_total.SQL.Add('WHERE vnd_cod = :pCodVnd');

  DM.qry_cad_venda.Open;
  DM.qry_pesq_funcionario.Open;
end;

procedure Tfrm_cad_venda.incrementaEstoque;
begin
  DM.qry_cad_produto.Close;
  DM.qry_cad_produto.SQL.Clear;
  DM.qry_cad_produto.SQL.Add(sqlCadProd + 'WHERE prod_cod = :pCodProd');
  DM.qry_cad_produto.Parameters.ParamByName('pCodProd').Value := DM.qry_lista_vnd_prodprod_cod.AsInteger;
  DM.qry_cad_produto.Open;
  DM.qry_cad_produto.Edit;
  DM.qry_cad_produtoprod_estq.Value := DM.qry_cad_produtoprod_estq.Value + DM.qry_lista_vnd_prodvnd_prod_qtd.Value;
  DM.qry_cad_produto.Post;
  DM.qry_cad_produto.Close;
  DM.qry_cad_produto.SQL.Clear;
  DM.qry_cad_produto.SQL.Add(sqlCadProd);
end;

end.

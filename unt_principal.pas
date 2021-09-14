unit unt_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.ImgList, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, System.ImageList;

type
  Tfrm_principal = class(TForm)
    atlAbreForm: TActionList;
    actCadFornecedores: TAction;
    actCadClientes: TAction;
    actConsultaFornecedores: TAction;
    actConsultaClientes: TAction;
    actSair: TAction;
    actCadProdutos: TAction;
    actConsultaProdutos: TAction;
    actCadFuncionarios: TAction;
    actCadVenda: TAction;
    actCadCompras: TAction;
    mmMenu: TMainMenu;
    CADASTROS1: TMenuItem;
    Fornecedores1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Funcionrios1: TMenuItem;
    CONSULTAS1: TMenuItem;
    Fornecesores1: TMenuItem;
    Clientes2: TMenuItem;
    Produtos2: TMenuItem;
    VENDA1: TMenuItem;
    SAIR1: TMenuItem;
    Compra1: TMenuItem;
    Venda2: TMenuItem;
    img_48_24: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    stbInfo: TStatusBar;
    tmrDtHora: TTimer;
    procedure actSairExecute(Sender: TObject);
    procedure tmrDtHoraTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actCadFornecedoresExecute(Sender: TObject);
    procedure actCadClientesExecute(Sender: TObject);
    procedure actCadVendaExecute(Sender: TObject);
    procedure actCadComprasExecute(Sender: TObject);
    procedure actConsultaFornecedoresExecute(Sender: TObject);
    procedure actConsultaClientesExecute(Sender: TObject);
    procedure actCadProdutosExecute(Sender: TObject);
    procedure actConsultaProdutosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

uses unt_cad_fornecedor, unt_cad_cliente, unt_cad_venda, unt_cad_compra,
  unt_pesq_fornecedor_c, unt_pesq_cliente_c, unt_cad_pesq_produtos;



procedure Tfrm_principal.actCadClientesExecute(Sender: TObject);
var frm_cad_cliente : Tfrm_cad_cliente;
begin
  frm_cad_cliente := Tfrm_cad_cliente.Create(Self);
  try
    frm_cad_cliente.ShowModal;
  finally
    frm_cad_cliente.Free;
  end;
end;

procedure Tfrm_principal.actCadComprasExecute(Sender: TObject);
var frm_cad_compra : Tfrm_cad_compra;
begin
  frm_cad_compra := Tfrm_cad_compra.Create(Self);
  try
    frm_cad_compra.ShowModal;
  finally
    frm_cad_compra.Free;
  end;
end;

procedure Tfrm_principal.actCadFornecedoresExecute(Sender: TObject);
var frm_cad_fornecedor : Tfrm_cad_fornecedor;
begin

  frm_cad_fornecedor := Tfrm_cad_fornecedor.Create(Self);

  try
    frm_cad_fornecedor.ShowModal;
  finally
    frm_cad_fornecedor.Free;
  end;

end;

procedure Tfrm_principal.actCadProdutosExecute(Sender: TObject);
begin
  frm_cad_pesq_produtos := Tfrm_cad_pesq_produtos.Create(Self);
  try
    frm_cad_pesq_produtos.ShowModal;
  finally
    frm_cad_pesq_produtos.Free;
  end;
end;

procedure Tfrm_principal.actCadVendaExecute(Sender: TObject);
var frm_cad_venda : Tfrm_cad_venda;
begin
  frm_cad_venda := Tfrm_cad_venda.Create(Self);
  try
    frm_cad_venda.ShowModal;
  finally
    frm_cad_venda.Free;
  end;
end;

procedure Tfrm_principal.actConsultaClientesExecute(Sender: TObject);
var frm_pesq_cliente : Tfrm_pesq_cliente_c;
begin
  frm_pesq_cliente := Tfrm_pesq_cliente_c.Create(Self);
  try
    frm_pesq_cliente.ShowModal;
  finally
    frm_pesq_cliente.Free;
  end;
end;

procedure Tfrm_principal.actConsultaFornecedoresExecute(Sender: TObject);
var frm_pesq_fornecedor_c : Tfrm_pesq_fornecedor_c;
begin
  frm_pesq_fornecedor_c := Tfrm_pesq_fornecedor_c.Create(Self);
  try
    frm_pesq_fornecedor_c.ShowModal;
  finally
    frm_pesq_fornecedor_c.Free;
  end;
end;

procedure Tfrm_principal.actConsultaProdutosExecute(Sender: TObject);
begin
  frm_cad_pesq_produtos := Tfrm_cad_pesq_produtos.Create(Self);
  frm_cad_pesq_produtos.Tag := 1;
  try
    frm_cad_pesq_produtos.ShowModal;
  finally
    frm_cad_pesq_produtos.Free;
  end;
end;

procedure Tfrm_principal.actSairExecute(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageBox(Application.Handle, 'Você deseja sair do sistema?', 'Sair',
  MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    // Caso seja necessário fechar alguma Query, o comando deve ser inserido aqui
    Action := caFree; // Ação do objeto TCloseAction para fechar o form
  end
  else
  begin
    Action := caNone; // A ação do objeto TCloseAction recebe um valor nulo
  end;
end;

procedure Tfrm_principal.tmrDtHoraTimer(Sender: TObject);
begin
  // Exibe a hora no 1º painel do statusBar - Ex: 09:59:02
  stbInfo.Panels[0].Text := ' ' + FormatDateTime('hh:nn:ss',now);
  // Exibe a data no 2º painel do statusBar - Ex: dia da semana, dia mês, ano
  stbInfo.Panels[1].Text := ' ' + FormatDateTime(
  'dddd", "dd" de "mmmm" de "yyyy',now);
end;

end.

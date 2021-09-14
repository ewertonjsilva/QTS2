program SistemaComercial;

uses
  Vcl.Forms,
  UDM in 'UDM.pas' {DM: TDataModule},
  unt_principal in 'unt_principal.pas' {frm_principal},
  unt_cad_fornecedor in 'unt_cad_fornecedor.pas' {frm_cad_fornecedor},
  unt_cad_cliente in 'unt_cad_cliente.pas' {frm_cad_cliente},
  unt_pesq_fornecedor_s in 'unt_pesq_fornecedor_s.pas' {frm_pesq_fornecedor_s},
  unt_pesq_fornecedor_c in 'unt_pesq_fornecedor_c.pas' {frm_pesq_fornecedor_c},
  unt_pesq_cliente_s in 'unt_pesq_cliente_s.pas' {frm_pesq_cliente_s},
  unt_pesq_cliente_c in 'unt_pesq_cliente_c.pas' {frm_pesq_cliente_c},
  unt_cad_telefone_forn in 'unt_cad_telefone_forn.pas' {frm_cad_telefone_forn},
  unt_cad_fornecedor_produtos in 'unt_cad_fornecedor_produtos.pas' {frm_cad_fornecedor_produtos},
  unt_cad_compra in 'unt_cad_compra.pas' {frm_cad_compra},
  unt_pesq_compra in 'unt_pesq_compra.pas' {frm_pesq_compra},
  unt_cad_venda in 'unt_cad_venda.pas' {frm_cad_venda},
  unt_pesq_venda in 'unt_pesq_venda.pas' {frm_pesq_venda},
  unt_cad_telefone_cli in 'unt_cad_telefone_cli.pas' {frm_cad_telefone_cli},
  unt_pesq_fornecedor_produtos in 'unt_pesq_fornecedor_produtos.pas' {frm_pesq_fornecedor_produtos},
  unt_cad_produto_venda in 'unt_cad_produto_venda.pas' {frm_cad_produto_venda},
  unt_cad_produto_compra in 'unt_cad_produto_compra.pas' {frm_cad_produto_compra},
  unt_modelo in 'unt_modelo.pas' {frm_modelo},
  uEndereco in 'uEndereco.pas',
  unt_heranca in 'unt_heranca.pas' {frm_heranca},
  unt_cad_pesq_produtos in 'unt_cad_pesq_produtos.pas' {frm_cad_pesq_produtos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.Run;
end.

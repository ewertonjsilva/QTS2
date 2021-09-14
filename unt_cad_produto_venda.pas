unit unt_cad_produto_venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls;

type
  Tfrm_cad_produto_venda = class(TForm)
    ds_add_prod: TDataSource;
    lbl_cod_vnd: TLabel;
    lbl_cod_prod: TLabel;
    lbl_qtd_prod: TLabel;
    lbl_vlr_unit: TLabel;
    btn_add_prod: TBitBtn;
    btn_gravar: TBitBtn;
    btn_cancelar: TBitBtn;
    dbt_vnd: TDBText;
    dbt_prod: TDBText;
    dbt_valor: TDBText;
    dbe_qtd: TDBEdit;
    dbt_nome: TDBText;
    ds_nome_prod: TDataSource;
    img_prod: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_gravarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_add_prodClick(Sender: TObject);
    procedure ds_add_prodDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    const sqlCadVndProd = 'SELECT vnd_cod, prod_cod, vnd_prod_qtd, vnd_prod_valor FROM VENDA_PRODUTOS ';
    const sqlCadProd = 'SELECT prod_cod, prod_nome, prod_img, prod_estq, prod_vlr_comp, prod_vlr_vnd, prod_lucro FROM PRODUTOS ';
  public
    { Public declarations }
  end;

var
  frm_cad_produto_venda: Tfrm_cad_produto_venda;

implementation

{$R *.dfm}

uses UDM, unt_cad_pesq_produtos;

procedure Tfrm_cad_produto_venda.btn_add_prodClick(Sender: TObject);
begin
  frm_cad_pesq_produtos := Tfrm_cad_pesq_produtos.Create(Self);
  frm_cad_pesq_produtos.Tag := 2;
  try
    frm_cad_pesq_produtos.ShowModal;
  finally
    frm_cad_pesq_produtos.Free;
    dbe_qtd.SetFocus;
  end;
end;

procedure Tfrm_cad_produto_venda.btn_cancelarClick(Sender: TObject);
begin
  ds_add_prod.DataSet.Cancel;
  if (frm_cad_produto_venda.Tag = 1) then
  begin
    DM.qry_cad_produto.Close;
    DM.qry_cad_produto.SQL.Clear;
    DM.qry_cad_produto.SQL.Add(sqlCadProd + 'WHERE prod_cod = :pCodProd');
    DM.qry_cad_produto.Parameters.ParamByName('pCodProd').Value := DM.qry_lista_vnd_prodprod_cod.AsInteger;
    DM.qry_cad_produto.Open;
    DM.qry_cad_produto.Edit;
    DM.qry_cad_produtoprod_estq.Value := DM.qry_cad_produtoprod_estq.Value - DM.qry_lista_vnd_prodvnd_prod_qtd.Value;
    DM.qry_cad_produto.Post;
    DM.qry_cad_produto.Close;
  end;
  Close;
end;

procedure Tfrm_cad_produto_venda.btn_gravarClick(Sender: TObject);
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

  if (DM.qry_cad_vnd_prodprod_cod.Value = Null) then
  begin
    valida := false;
    mensagem.Append('- Selecione um produto para a venda.' + sLineBreak);
  end;
  if (dbe_qtd.Text = '') then
  begin
    valida := false;
    mensagem.Append('- Insira a quantidade de produtos.' + sLineBreak);
  end;
  if (dbe_qtd.Text = '0') then
  begin
    valida := false;
    mensagem.Append('- O número de produtos não pode ser zero.' + sLineBreak);
  end;

  // Mensagem de erro
  if (valida = False) then
  begin
    Application.MessageBox(pChar(mensagem.ToString), 'Erro', MB_ICONERROR);
  end
  else
  begin

    DM.qry_cad_produto.Close;
    DM.qry_cad_produto.SQL.Clear;
    DM.qry_cad_produto.SQL.Add(sqlCadProd + 'WHERE prod_cod = :pCodProd');
    DM.qry_cad_produto.Parameters.ParamByName('pCodProd').Value := DM.qry_cad_vnd_prodprod_cod.AsInteger;
    DM.qry_cad_produto.Open;

    if (DM.qry_cad_produtoprod_estq.Value < StrToInt(dbe_qtd.Text)) then
    begin
      Application.MessageBox(pChar('Não temos esta quantia em estoque!' + sLineBreak +
                              'Estoque igual a: ' + IntToStr(DM.qry_cad_produtoprod_estq.Value)),
                              'Erro', MB_ICONERROR);
    end
    else
    begin
      DM.qry_cad_produto.Edit;
      DM.qry_cad_produtoprod_estq.Value := DM.qry_cad_produtoprod_estq.Value - StrToInt(dbe_qtd.Text);
      DM.qry_cad_produto.Post;
      DM.qry_cad_produto.Close;
      ds_add_prod.DataSet.Post;
      DM.qry_lista_vnd_prod.Close;
      DM.qry_lista_vnd_prod.Open;
      FreeAndNil(mensagem);
      Close;
    end;

  end;

  FreeAndNil(mensagem);

end;

procedure Tfrm_cad_produto_venda.ds_add_prodDataChange(Sender: TObject;
  Field: TField);
begin
  DM.qry_pesq_produto.Close;
  DM.qry_pesq_produto.SQL.Clear;
  DM.qry_pesq_produto.SQL.Add(sqlCadProd + 'WHERE prod_cod = :pCodigo');
  DM.qry_pesq_produto.Parameters.ParamByName('pCodigo').Value := DM.qry_cad_vnd_prodprod_cod.AsInteger;
  DM.qry_pesq_produto.Open;

  if (DM.qry_pesq_produtoprod_img.Value <> '') then
    begin
      if (FileExists(ExtractFilePath(Application.ExeName) +
          '\Imagens\' + DM.qry_pesq_produtoprod_img.Value)) then
      begin
        img_prod.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
        '\Imagens\' + DM.qry_pesq_produtoprod_img.Value);
      end
      else
      begin
        img_prod.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
        '\Imagens\nEnc.jpg');
      end;
    end
    else
    begin
      img_prod.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
      '\Imagens\SemImagem.jpg');
    end;

end;

procedure Tfrm_cad_produto_venda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.qry_cad_vnd_prod.Close;
  DM.qry_cad_vnd_prod.SQL.Clear;
  DM.qry_cad_vnd_prod.SQL.Add(sqlCadVndProd);

  DM.qry_cad_produto.SQL.Clear;
  DM.qry_cad_produto.SQL.Add(sqlCadProd);

  DM.qry_pesq_produto.Close;
  DM.qry_pesq_produto.SQL.Add(sqlCadProd);
end;

procedure Tfrm_cad_produto_venda.FormCreate(Sender: TObject);
begin
  DM.qry_cad_vnd_prod.Close;
  DM.qry_cad_vnd_prod.SQL.Clear;
  DM.qry_cad_vnd_prod.SQL.Add(sqlCadVndProd + 'WHERE vnd_cod = :pCodVnd AND prod_cod = :pCodProd');
end;

procedure Tfrm_cad_produto_venda.FormShow(Sender: TObject);
begin
  if (frm_cad_produto_venda.Tag = 0) then
  begin
    DM.qry_cad_vnd_prod.Open;
    DM.qry_cad_vnd_prod.Append;
    DM.qry_cad_vnd_prodvnd_cod.Value := DM.qry_cad_vendavnd_cod.AsInteger;
  end
  else
  begin
    DM.qry_cad_vnd_prod.Parameters.ParamByName('pCodVnd').Value := DM.qry_lista_vnd_prodvnd_cod.AsInteger;
    DM.qry_cad_vnd_prod.Parameters.ParamByName('pCodProd').Value := DM.qry_lista_vnd_prodprod_cod.AsInteger;
    DM.qry_cad_vnd_prod.Open;
    DM.qry_cad_vnd_prod.Edit;
    dbe_qtd.SetFocus;
  end;

end;

end.

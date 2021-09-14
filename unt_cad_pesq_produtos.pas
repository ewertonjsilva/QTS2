unit unt_cad_pesq_produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unt_heranca, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.DBCtrls, Vcl.Mask, Vcl.ExtDlgs, JPEG;

type
  Tfrm_cad_pesq_produtos = class(Tfrm_heranca)
    lbl_cod: TLabel;
    lbl_nome: TLabel;
    dbe_nome: TDBEdit;
    lbl_imagem: TLabel;
    dbe_imagem: TDBEdit;
    lbl_estoque: TLabel;
    dbe_estoque: TDBEdit;
    lbl_valor_compra: TLabel;
    dbe_valor_compra: TDBEdit;
    lbl_valor_venda: TLabel;
    dbe_valor_venda: TDBEdit;
    lbl_p_lucro: TLabel;
    dbe_p_lucro: TDBEdit;
    dbt_codigo: TDBText;
    btn_img_prod: TBitBtn;
    img_prod: TImage;
    opd_img_prod: TOpenPictureDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_pesquisaClick(Sender: TObject);
    procedure dbg_pesquisaDblClick(Sender: TObject);
    procedure btn_img_prodClick(Sender: TObject);
    procedure ds_dadosDataChange(Sender: TObject; Field: TField);
    procedure ds_dadosStateChange(Sender: TObject);
  private
    parametros : String;
    const sql_padrao = 'SELECT prod_cod, prod_nome, prod_img, prod_estq, ' +
                       'prod_vlr_comp, prod_vlr_vnd, prod_lucro ' +
                       'FROM PRODUTOS ';
  public
    { Public declarations }
  end;

var
  frm_cad_pesq_produtos: Tfrm_cad_pesq_produtos;

implementation

{$R *.dfm}

uses UDM;

procedure Tfrm_cad_pesq_produtos.btn_img_prodClick(Sender: TObject);
var origem: String;
begin
  inherited;
  if (opd_img_prod.Execute()) then
  begin
    img_prod .Picture.LoadFromFile(opd_img_prod.FileName);
    origem := opd_img_prod.FileName;
    Delete(origem, 1, Length(ExtractFilePath(opd_img_prod.FileName)));
    DM.qry_cad_fornecedorforn_img.Value := origem;
  end;
end;

procedure Tfrm_cad_pesq_produtos.btn_pesquisaClick(Sender: TObject);
begin
  inherited;
  if (rbt_codigo.Checked = true) then
  begin
    DM.qry_cad_produto.Close;
    DM.qry_cad_produto.Parameters.ParamByName('p_codigo').Value := StrToInt(edt_pesquisa.Text);
    DM.qry_cad_produto.Parameters.ParamByName('p_nome').Value := Null;
    DM.qry_cad_produto.Open;
  end
  else
  begin
    DM.qry_cad_produto.Close;
    DM.qry_cad_produto.Parameters.ParamByName('p_codigo').Value := Null;
    DM.qry_cad_produto.Parameters.ParamByName('p_nome').Value := '%' + edt_pesquisa.Text + '%';
    DM.qry_cad_produto.Open;
  end;

end;

procedure Tfrm_cad_pesq_produtos.dbg_pesquisaDblClick(Sender: TObject);
begin
  inherited;
  if (frm_cad_pesq_produtos.Tag = 2) then
  begin
    DM.qry_cad_vnd_prodprod_cod.Value := DM.qry_cad_produtoprod_cod.AsInteger;
    DM.qry_cad_vnd_prodvnd_prod_valor.Value := DM.qry_cad_produtoprod_vlr_vnd.AsFloat;
    Close;
  end;
end;

procedure Tfrm_cad_pesq_produtos.ds_dadosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if ((ds_dados.State = dsBrowse) and (not ds_dados.DataSet.IsEmpty)) then
  begin
    if (DM.qry_cad_produtoprod_img.Value <> '') then
    begin
      if (FileExists(ExtractFilePath(Application.ExeName) +
          '\Imagens\' + DM.qry_cad_produtoprod_img.Value)) then
      begin
        img_prod.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
        '\Imagens\' + DM.qry_cad_produtoprod_img.Value);
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
end;

procedure Tfrm_cad_pesq_produtos.ds_dadosStateChange(Sender: TObject);
begin
  inherited;
  btn_img_prod.Enabled := ds_dados.State in [dsInsert, dsEdit];
end;

procedure Tfrm_cad_pesq_produtos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DM.qry_cad_produto.Close;
  DM.qry_cad_produto.SQL.Clear;
  DM.qry_cad_produto.SQL.Add(sql_padrao);
end;

procedure Tfrm_cad_pesq_produtos.FormShow(Sender: TObject);
begin
  inherited;
  parametros := 'WHERE (prod_cod = :p_codigo or prod_nome like :p_nome) ';
  DM.qry_cad_produto.Close;
  DM.qry_cad_produto.SQL.Clear;
  DM.qry_cad_produto.SQL.Add(sql_padrao + parametros);

  if (frm_cad_pesq_produtos.Tag = 2) then
  begin
   DM.qry_cad_produto.SQL.Add('AND (prod_cod NOT IN (SELECT prod_cod FROM VENDA_PRODUTOS WHERE vnd_cod = ' +
                              IntToStr(DM.qry_cad_vnd_prodvnd_cod.AsInteger) + '))');
  end;

  DM.qry_cad_produto.Parameters.ParamByName('p_codigo').Value := Null;
  DM.qry_cad_produto.Parameters.ParamByName('p_nome').Value := Null;

  DM.qry_cad_produto.Open;

  if (frm_cad_pesq_produtos.Tag = 0) then tbs_pesquisa.TabVisible := False;
  if (frm_cad_pesq_produtos.Tag = 1) then btn_adicionar.Visible := False;
  if (frm_cad_pesq_produtos.Tag = 2) then tbs_cadastro.TabVisible := False;
end;

end.

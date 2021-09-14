inherited frm_cad_pesq_produtos: Tfrm_cad_pesq_produtos
  Caption = 'PRODUTOS'
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 23
  inherited pgc_heranca: TPageControl
    ActivePage = tbs_pesquisa
    inherited tbs_cadastro: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 34
      ExplicitWidth = 939
      ExplicitHeight = 428
      object lbl_cod: TLabel [0]
        Left = 16
        Top = 16
        Width = 57
        Height = 23
        Caption = 'C'#243'digo'
      end
      object lbl_nome: TLabel [1]
        Left = 168
        Top = 16
        Width = 49
        Height = 23
        Caption = 'Nome'
        FocusControl = dbe_nome
      end
      object lbl_imagem: TLabel [2]
        Left = 670
        Top = 16
        Width = 70
        Height = 23
        Caption = 'Imagem'
        FocusControl = dbe_imagem
      end
      object lbl_estoque: TLabel [3]
        Left = 16
        Top = 88
        Width = 67
        Height = 23
        Caption = 'Estoque'
        FocusControl = dbe_estoque
      end
      object lbl_valor_compra: TLabel [4]
        Left = 16
        Top = 168
        Width = 111
        Height = 23
        Caption = 'Valor compra'
        FocusControl = dbe_valor_compra
      end
      object lbl_valor_venda: TLabel [5]
        Left = 350
        Top = 168
        Width = 99
        Height = 23
        Caption = 'Valor venda'
        FocusControl = dbe_valor_venda
      end
      object lbl_p_lucro: TLabel [6]
        Left = 350
        Top = 88
        Width = 162
        Height = 23
        Caption = 'Porcentual de lucro'
        FocusControl = dbe_p_lucro
      end
      object dbt_codigo: TDBText [7]
        Left = 16
        Top = 40
        Width = 120
        Height = 31
      end
      object img_prod: TImage [8]
        Left = 670
        Top = 88
        Width = 250
        Height = 135
        Stretch = True
      end
      object dbe_nome: TDBEdit
        Left = 168
        Top = 40
        Width = 449
        Height = 31
        DataField = 'prod_nome'
        DataSource = ds_dados
        TabOrder = 5
      end
      object dbe_imagem: TDBEdit
        Left = 670
        Top = 40
        Width = 250
        Height = 31
        DataField = 'prod_img'
        DataSource = ds_dados
        TabOrder = 6
      end
      object dbe_estoque: TDBEdit
        Left = 16
        Top = 117
        Width = 267
        Height = 31
        DataField = 'prod_estq'
        DataSource = ds_dados
        TabOrder = 7
      end
      object dbe_valor_compra: TDBEdit
        Left = 16
        Top = 192
        Width = 267
        Height = 31
        DataField = 'prod_vlr_comp'
        DataSource = ds_dados
        TabOrder = 8
      end
      object dbe_valor_venda: TDBEdit
        Left = 350
        Top = 192
        Width = 267
        Height = 31
        DataField = 'prod_vlr_vnd'
        DataSource = ds_dados
        TabOrder = 9
      end
      object dbe_p_lucro: TDBEdit
        Left = 350
        Top = 112
        Width = 267
        Height = 31
        DataField = 'prod_lucro'
        DataSource = ds_dados
        TabOrder = 10
      end
      object btn_img_prod: TBitBtn
        Left = 845
        Top = 17
        Width = 75
        Height = 23
        Caption = '...'
        TabOrder = 11
        OnClick = btn_img_prodClick
      end
    end
    inherited tbs_pesquisa: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 34
      ExplicitWidth = 939
      ExplicitHeight = 428
      inherited pnl_info_pesquisa: TPanel
        inherited btn_pesquisa: TBitBtn
          OnClick = btn_pesquisaClick
        end
      end
      inherited dbg_pesquisa: TDBGrid
        OnDblClick = dbg_pesquisaDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'prod_cod'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'prod_nome'
            Width = 360
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'prod_estq'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'prod_vlr_comp'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'prod_vlr_vnd'
            Width = 130
            Visible = True
          end>
      end
    end
  end
  inherited ds_dados: TDataSource
    DataSet = DM.qry_cad_produto
    OnDataChange = ds_dadosDataChange
  end
  object opd_img_prod: TOpenPictureDialog
    Left = 772
    Top = 34
  end
end

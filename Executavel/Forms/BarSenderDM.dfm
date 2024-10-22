object frmBarSenderDM: TfrmBarSenderDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 275
  Width = 368
  object dbConect: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=D:\BarSender\BARSENDER.FDB'
      'Server=localHost'
      'DriverID=FB')
    Left = 33
    Top = 26
  end
  object fbDriver: TFDPhysFBDriverLink
    VendorLib = 'D:\BarSender\BPL\fbclient.dll'
    Left = 33
    Top = 79
  end
  object fdCursorWait: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 33
    Top = 132
  end
  object qryContatos: TFDQuery
    OnNewRecord = qryContatosNewRecord
    Connection = dbConect
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      'SELECT'
      '  NOME_CONTATO,'
      '  NUMERO_CONTATO,'
      '  MARCADO'
      'FROM CONTATOS')
    Left = 119
    Top = 24
    object qryContatosNOME_CONTATO: TStringField
      FieldName = 'NOME_CONTATO'
      Origin = 'NOME_CONTATO'
      FixedChar = True
      Size = 50
    end
    object qryContatosNUMERO_CONTATO: TStringField
      FieldName = 'NUMERO_CONTATO'
      Origin = 'NUMERO_CONTATO'
      FixedChar = True
      Size = 30
    end
    object qryContatosMARCADO: TSmallintField
      FieldName = 'MARCADO'
      Origin = 'MARCADO'
    end
  end
  object dsContatos: TDataSource
    DataSet = qryContatos
    Left = 121
    Top = 79
  end
  object qryConfiguracao: TFDQuery
    Connection = dbConect
    SQL.Strings = (
      'SELECT *'
      '  FROM CONFIGURACAO')
    Left = 213
    Top = 24
    object qryConfiguracaoUSU_NOME: TStringField
      FieldName = 'USU_NOME'
      Origin = 'USU_NOME'
      FixedChar = True
      Size = 50
    end
    object qryConfiguracaoUSU_NUMERO: TStringField
      FieldName = 'USU_NUMERO'
      Origin = 'USU_NUMERO'
      FixedChar = True
      Size = 30
    end
    object qryConfiguracaoUSU_TOKEN: TStringField
      FieldName = 'USU_TOKEN'
      Origin = 'USU_TOKEN'
      Size = 255
    end
    object qryConfiguracaoMENSAGEM_PADRAO: TStringField
      FieldName = 'MENSAGEM_PADRAO'
      Origin = 'MENSAGEM_PADRAO'
      Size = 500
    end
    object qryConfiguracaoDATA_VALIDACAO: TDateField
      FieldName = 'DATA_VALIDACAO'
      Origin = 'DATA_VALIDACAO'
    end
  end
  object dsConfiguracao: TDataSource
    DataSet = qryConfiguracao
    Left = 213
    Top = 79
  end
  object DelContatos: TFDQuery
    BeforeExecute = DelContatosBeforeExecute
    Connection = dbConect
    SQL.Strings = (
      'DELETE FROM CONTATOS'
      'WHERE ( NOME_CONTATO = :NOME_CONTATO )'
      '  AND ( NUMERO_CONTATO = :NUMERO_CONTATO )')
    Left = 37
    Top = 200
    ParamData = <
      item
        Name = 'NOME_CONTATO'
        ParamType = ptInput
      end
      item
        Name = 'NUMERO_CONTATO'
        ParamType = ptInput
      end>
    object StringField1: TStringField
      FieldName = 'USU_NOME'
      Origin = 'USU_NOME'
      FixedChar = True
      Size = 50
    end
    object StringField2: TStringField
      FieldName = 'USU_NUMERO'
      Origin = 'USU_NUMERO'
      FixedChar = True
      Size = 30
    end
    object StringField3: TStringField
      FieldName = 'USU_TOKEN'
      Origin = 'USU_TOKEN'
      Size = 255
    end
  end
end

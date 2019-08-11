object dmConnection: TdmConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 275
  Width = 421
  object ADOConnection: TADOConnection
    CommandTimeout = 600
    KeepConnection = False
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 91
    Top = 9
  end
  object qClaim: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select c.ID, c.Name, c.GrossClaim "Gross Claim", c.Deductible, '
      
        '          c.GrossClaim - c.Deductible "Net Claim", c.Year, ct.Na' +
        'me Type'
      'from Claim c'
      '  left join ClaimType ct on ct.ID = c.TypeID')
    Left = 80
    Top = 88
  end
  object qClaimType: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ClaimType')
    Left = 200
    Top = 88
  end
  object ADOCommand: TADOCommand
    Connection = ADOConnection
    Parameters = <>
    Left = 208
    Top = 8
  end
  object qOneRec: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      'from Claim'
      'where ID = :ID')
    Left = 296
    Top = 88
  end
end

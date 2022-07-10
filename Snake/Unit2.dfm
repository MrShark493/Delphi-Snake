object DebugConsole: TDebugConsole
  Left = 1288
  Top = 163
  BorderStyle = bsSingle
  Caption = 'DebugConsole'
  ClientHeight = 516
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ConsoleMemo: TMemo
    Left = 0
    Top = 0
    Width = 241
    Height = 480
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Debug Console')
    ParentFont = False
    TabOrder = 0
  end
  object CloseButton: TButton
    Left = 0
    Top = 480
    Width = 89
    Height = 33
    Caption = 'Close'
    TabOrder = 1
    OnClick = CloseButtonClick
  end
  object Memo: TMemo
    Left = 240
    Top = 0
    Width = 240
    Height = 480
    TabOrder = 2
  end
  object EnterButton: TButton
    Left = 368
    Top = 480
    Width = 107
    Height = 33
    Caption = 'Enter'
    TabOrder = 3
    OnClick = EnterButtonClick
  end
end

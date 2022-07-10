object Form1: TForm1
  Left = 740
  Top = 148
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Snake'
  ClientHeight = 315
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object PauseLabel: TLabel
    Left = 48
    Top = 128
    Width = 194
    Height = 25
    Caption = 'Tap any button to start'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object MainMenu1: TMainMenu
    object Exit1: TMenuItem
      Caption = 'Exit'
      OnClick = Exit1Click
    end
    object ConsoleDebug1: TMenuItem
      Caption = 'ConsoleDebug'
      OnClick = ConsoleDebug1Click
    end
    object Score01: TMenuItem
      Caption = 'Score: 0'
      Enabled = False
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 75
    OnTimer = TimerTimer
    Left = 32
  end
  object TimerAdv: TTimer
    Interval = 37
    OnTimer = TimerAdvTimer
    Left = 32
    Top = 32
  end
end

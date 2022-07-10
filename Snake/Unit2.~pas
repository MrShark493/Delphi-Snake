unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDebugConsole = class(TForm)
    ConsoleMemo: TMemo;
    CloseButton: TButton;
    Memo: TMemo;
    EnterButton: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DebugConsole: TDebugConsole;

implementation

uses Unit1;

{$R *.dfm}

Procedure Pause;
  begin
    if Unit1.Form1.Timer.Enabled = False
      then
        Unit1.Form1.Timer.Enabled := True
      else
        Unit1.Form1.Timer.Enabled := False;
  end;

procedure TDebugConsole.CloseButtonClick(Sender: TObject);
  begin
    Unit1.DebugCall := False;
    Unit2.DebugConsole.Close;
  end;

procedure TDebugConsole.EnterButtonClick(Sender: TObject);
  var
    n: integer;
    str: string;
    check: boolean;
  begin
    n := Memo.Lines.Count - 1;
    str := Memo.Lines[n];
    if str = '/levelup'
      then
        begin
          Unit1.Snake.LevelUp;
          Memo.Lines.Add('Level Up activated');
          check := true;
        end;
    if str = '/defeat'
      then
        begin
          Unit1.Snake.Defeat;
          Memo.Lines.Add('Auto Defeat');
          check := true;
        end;
    if str = '/pause'
      then
        begin
          Pause;
          Memo.Lines.Add('Auto Pause');
          check := true;
        end;
    if check = false
      then
        Memo.Lines.Add('Wrong command');
  end;

end.

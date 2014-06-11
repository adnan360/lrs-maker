unit frm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, EditBtn, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnGenerate: TBitBtn;
    FileInput: TFileNameEdit;
    FileOutput: TFileNameEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Process1: TProcess;
    procedure btnGenerateClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnGenerateClick(Sender: TObject);
begin
  Process1.CurrentDirectory:=Application.Location;
  Process1.Executable:='lazres.exe';
  Process1.Parameters.Clear;
  Process1.Parameters.Add('"'+FileOutput.FileName+'"');
  Process1.Parameters.Add('"'+FileInput.FileName+'"');
  Memo1.Lines.Clear; // get it ready for output
  Process1.Execute;

  // Capture output
  Memo1.Lines.LoadFromStream(Process1.Output);

  if pos('ResourceName=', Memo1.Lines[0]) <> 0 then begin // successful!
    // Wiki link
    Memo1.Lines.Add(#13#10'Check out this page on how to use it: '+
        'http://wiki.lazarus.freepascal.org/Lazarus_Resources#Lazarus_resources'#13#10);

    // Usage instructions
    Memo1.Lines.Add('* Use the output information in the code.'#13#10+
    'Make sure that the LRS file is in your project directory.'#13#10+
    ''#13#10+
    '=== Example code for loading image resource: ==='#13#10+
    'uses'#13#10+
    '  ...LResources...;'#13#10+
    'procedure exampleproc;'#13#10+
    'begin'#13#10+
    '  Image1.Picture.LoadFromLazarusResource(''image''); // replace "image" with your ResourceName from output'#13#10+
    'end;'#13#10+
    'initialization'#13#10+
    '  {$I '+ExtractFileName(FileOutput.FileName)+'}');
  end;
end;

end.


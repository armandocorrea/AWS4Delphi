unit UfrmSamples;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmSamples = class(TForm)
    FileOpenDialog: TFileOpenDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDestination: TEdit;
    edtMessage: TEdit;
    btnSendSMS: TButton;
    edtRegion: TEdit;
    edtAppId: TEdit;
    btnAddPhone: TButton;
    lstDestinations: TListBox;
    GroupBox2: TGroupBox;
    edtEmailRecipient: TEdit;
    edtMessageEmail: TEdit;
    edtSubject: TEdit;
    edtEmailSender: TEdit;
    edtRegionAWSEmail: TEdit;
    btnSendEmailWithFile: TButton;
    btnSendEmail: TButton;
    btnSearchFile: TButton;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    btnAddRecipient: TButton;
    lstRecipient: TListBox;
    lstFilePath: TListBox;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    btnSearchFileS3: TButton;
    btnSendFile: TButton;
    btnSendFileMP: TButton;
    edtRegionS3: TEdit;
    edtBucketName: TEdit;
    Label5: TLabel;
    Label14: TLabel;
    edtFilePath: TEdit;
    Label15: TLabel;
    btnDelDestination: TButton;
    btnDelRecipient: TButton;
    btnDelFile: TButton;
    procedure btnSendSMSClick(Sender: TObject);
    procedure btnSearchFileS3Click(Sender: TObject);
    procedure btnSendFileClick(Sender: TObject);
    procedure btnSendFileMPClick(Sender: TObject);
    procedure btnSearchFileClick(Sender: TObject);
    procedure btnSendEmailClick(Sender: TObject);
    procedure btnSendEmailWithFileClick(Sender: TObject);
    procedure btnAddPhoneClick(Sender: TObject);
    procedure btnAddRecipientClick(Sender: TObject);
    procedure btnDelDestinationClick(Sender: TObject);
    procedure btnDelRecipientClick(Sender: TObject);
    procedure btnDelFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSamples: TfrmSamples;

implementation

{$R *.dfm}

uses
  AWS4Delphi.Interfaces,
  AWS4Delphi.SMS,
  AWS4Delphi.S3,
  AWS4Delphi.Email;

procedure TfrmSamples.btnAddPhoneClick(Sender: TObject);
begin
  lstDestinations.Items.Add(Trim(edtDestination.Text));
end;

procedure TfrmSamples.btnSearchFileS3Click(Sender: TObject);
begin
  FileOpenDialog.Execute;
  edtFilePath.Text := FileOpenDialog.FileName;
end;

procedure TfrmSamples.btnDelDestinationClick(Sender: TObject);
begin
  if lstDestinations.ItemIndex = -1 then
    Exit;

  lstDestinations.Items.Delete(lstDestinations.ItemIndex);
end;

procedure TfrmSamples.btnDelFileClick(Sender: TObject);
begin
  if lstFilePath.ItemIndex = -1 then
    exit;

  lstFilePath.Items.Delete(lstFilePath.ItemIndex);
end;

procedure TfrmSamples.btnDelRecipientClick(Sender: TObject);
begin
  if lstRecipient.ItemIndex = -1 then
    exit;

  lstRecipient.Items.Delete(lstRecipient.ItemIndex);
end;

procedure TfrmSamples.btnAddRecipientClick(Sender: TObject);
begin
  lstRecipient.Items.Add(edtEmailRecipient.Text);
end;

procedure TfrmSamples.btnSearchFileClick(Sender: TObject);
begin
  FileOpenDialog.Execute;
  lstFilePath.Items.Add(FileOpenDialog.FileName);
end;

procedure TfrmSamples.btnSendEmailClick(Sender: TObject);
var
  xResult: String;
begin
  TAmazonEmail.New
    .SetRegion(Trim(edtRegionAWSEmail.Text))
    .SetEmailSender(Trim(edtEmailSender.Text))
    .SetRecipient(lstRecipient.Items)
    .SetSubject(Trim(edtSubject.Text))
    .SetMessageBody(Trim(edtMessageEmail.Text))
    .SendEmail(xResult);

  ShowMessage(xResult);
end;

procedure TfrmSamples.btnSendEmailWithFileClick(Sender: TObject);
var
  xResult: String;
begin
  TAmazonEmail.New
    .SetRegion(Trim(edtRegionAWSEmail.Text))
    .SetEmailSender(Trim(edtEmailSender.Text))
    .SetRecipient(lstRecipient.Items)
    .SetSubject(Trim(edtSubject.Text))
    .SetMessageBody(Trim(edtMessageEmail.Text))
    .SetFilePath(lstFilePath.Items)
    .SendEmailWithFile(xResult);

  ShowMessage(xResult);
end;

procedure TfrmSamples.btnSendFileClick(Sender: TObject);
var
  xResult: String;
begin
  TAmazonS3.New
    .SetFilePath(Trim(edtFilePath.Text))
    .SetRegion(Trim(edtRegionS3.Text))
    .SetBucketName(Trim(edtBucketName.Text))
    .SendFile(xResult);

  ShowMessage(xResult);
end;

procedure TfrmSamples.btnSendFileMPClick(Sender: TObject);
var
  xResult: String;
begin
  TAmazonS3.New
    .SetFilePath(Trim(edtFilePath.Text))
    .SetRegion(Trim(edtRegionS3.Text))
    .SetBucketName(Trim(edtBucketName.Text))
    .SendFileMP(xResult);

  ShowMessage(xResult);
end;

procedure TfrmSamples.btnSendSMSClick(Sender: TObject);
var
  xResult: String;
begin
  TAmazonPinpoint.New
    .SetPhoneNumber(lstDestinations.Items)
    .SetMessage(Trim(edtMessage.Text))
    .SetRegion(Trim(edtRegion.Text))
    .SetAppId(Trim(edtAppId.Text))
    .SendSMS(xResult);

  ShowMessage(xResult);
end;

end.

unit AWS4Delphi.Model.Email;

interface

uses
  System.JSON,
  System.Generics.Collections;

type
  TEmail = class
    private
      FRegionAWS: String;
      FEmailSender: String;
      FSubject: String;
      FMessageBody: String;
      FRecipientList: TList<String>;
      FFilePathList: TList<String>;

      FJSON: TJSONObject;
    public
      constructor Create;
      destructor Destroy; override;

      procedure AddRecipient(const aRecipient: String);
      procedure AddFile(const aFile: String);

      function JSONParameters: String;

      property RegionAWS: String   read FRegionAWS   write FRegionAWS;
      property EmailSender: String read FEmailSender write FEmailSender;
      property Subject: String     read FSubject     write FSubject;
      property MessageBody: String read FMessageBody write FMessageBody;
  end;

implementation

uses
  System.SysUtils;

{ TEmail }

procedure TEmail.AddFile(const aFile: String);
begin
  FFilePathList.Add(aFile);
end;

procedure TEmail.AddRecipient(const aRecipient: String);
begin
  FRecipientList.Add(aRecipient);
end;

constructor TEmail.Create;
begin
  FJSON := TJSONObject.Create;
  FRecipientList := TList<String>.Create;
  FFilePathList  := TList<String>.Create;
end;

destructor TEmail.Destroy;
begin
  FreeAndNil(FJSON);
  FreeAndNil(FRecipientList);
  FreeAndNil(FFilePathList);
  inherited;
end;

function TEmail.JSONParameters: String;
var
  xRecipientList: TJSONArray;
  xFileList: TJSONArray;
  xRecipient: String;
  xFile: String;
begin
  FJSON.AddPair('RegionAWS', FRegionAWS);
  FJSON.AddPair('EmailSender', FEmailSender);
  FJSON.AddPair('Subject', FSubject);
  FJSON.AddPair('MessageBody', FMessageBody);

  xRecipientList := TJSONArray.Create;
  for xRecipient in FRecipientList do
    xRecipientList.Add(xRecipient);

  FJSON.AddPair('RecipientList', xRecipientList);

  xFileList := TJSONArray.Create;
  for xFile in FFilePathList do
    xFileList.Add(xFile);

  FJSON.AddPair('FilePathList', xFileList);

  Result := FJSON.ToJSON;
end;

end.

unit AWS4Delphi.Email;

interface

uses
  AWS4Delphi.Interfaces,
  AWS4Delphi.Model.Email,
  System.Classes;

type
  //Signature DLL
  TSendEmail = function(aJSONParameters: PAnsiChar): PAnsiChar; stdcall;
  TSendEmailWithFile = function(aJSONParameters: PAnsiChar): PAnsiChar; stdcall;

  TAmazonEmail = class(TInterfacedObject, ISendEmail)
    private
      FEmail: TEmail;

      constructor Create;
    public
      class function New : ISendEmail;
      destructor Destroy; override;

      function SetRegion(const aRegion: String): ISendEmail;
      function SetEmailSender(const aEmail: String): ISendEmail;
      function SetSubject(const aSubject: String): ISendEmail;
      function SetMessageBody(const aMessage: String): ISendEmail;
      function SetRecipient(const aRecipient: String): ISendEmail; overload;
      function SetRecipient(const aRecipient: TStrings): ISendEmail; overload;
      function SetFilePath(const aFilePath: String): ISendEmail; overload;
      function SetFilePath(const aFilePath: TStrings): ISendEmail; overload;

      procedure SendEmail(var aResult: String);
      procedure SendEmailWithFile(var aResult: String);
  end;



implementation

uses
  Winapi.Windows, AWS4Delphi.Constants, System.SysUtils;

{ TAmazonEmail }

constructor TAmazonEmail.Create;
begin
  FEmail := TEmail.Create;
end;

destructor TAmazonEmail.Destroy;
begin
  FreeAndNil(FEmail);
  inherited;
end;

class function TAmazonEmail.New: ISendEmail;
begin
  Result := Self.Create;
end;

procedure TAmazonEmail.SendEmail(var aResult: String);
var
  xHandle: THandle;
  xSendFile: TSendEmail;
begin
  aResult := '';

  xHandle := LoadLibrary(NAME_DLL);

  if xHandle > 0 then
  begin
    try
      @xSendFile := GetProcAddress(xHandle, 'SendEmail'); //Method name of dll

      if @xSendFile <> nil then
      begin
        try
          aResult := xSendFile(PAnsiChar(AnsiString(FEmail.JSONParameters)));
        except
          on E: Exception do
            aResult := PAnsiChar(AnsiString(E.Message));
        end
      end
      else
        aResult := 'Método não carregado.';
    finally
      FreeLibrary(xHandle);
    end
  end
  else
    aResult := 'DLL não carregada.';
end;

procedure TAmazonEmail.SendEmailWithFile(var aResult: String);
var
  xHandle: THandle;
  xSendFile: TSendEmailWithFile;
begin
  aResult := '';

  xHandle := LoadLibrary(NAME_DLL);

  if xHandle > 0 then
  begin
    try
      @xSendFile := GetProcAddress(xHandle, 'SendEmailWithFile'); //Method name of dll

      if @xSendFile <> nil then
      begin
        try
          aResult := xSendFile(PAnsiChar(AnsiString(FEmail.JSONParameters)));
        except
          on E: Exception do
            aResult := PAnsiChar(AnsiString(E.Message));
        end
      end
      else
        aResult := 'Método não carregado.';
    finally
      FreeLibrary(xHandle);
    end
  end
  else
    aResult := 'DLL não carregada.';
end;

function TAmazonEmail.SetEmailSender(const aEmail: String): ISendEmail;
begin
  FEmail.EmailSender := aEmail;
  Result := Self;
end;

function TAmazonEmail.SetFilePath(const aFilePath: String): ISendEmail;
begin
  FEmail.AddFile(aFilePath);
  Result := Self;
end;

function TAmazonEmail.SetFilePath(const aFilePath: TStrings): ISendEmail;
var
  xFile: String;
begin
  for xFile in aFilePath do
    Self.SetFilePath(xFile);

  Result := Self;
end;

function TAmazonEmail.SetMessageBody(const aMessage: String): ISendEmail;
begin
  FEmail.MessageBody := aMessage;
  Result := Self;
end;

function TAmazonEmail.SetRecipient(const aRecipient: String): ISendEmail;
begin
  FEmail.AddRecipient(aRecipient);
  Result := Self;
end;

function TAmazonEmail.SetRecipient(const aRecipient: TStrings): ISendEmail;
var
  xRecipient: String;
begin
  for xRecipient in aRecipient do
    Self.SetRecipient(xRecipient);

  Result := Self;
end;

function TAmazonEmail.SetRegion(const aRegion: String): ISendEmail;
begin
  FEmail.RegionAWS := aRegion;
  Result := Self;
end;

function TAmazonEmail.SetSubject(const aSubject: String): ISendEmail;
begin
  FEmail.Subject := aSubject;
  Result := Self;
end;

end.

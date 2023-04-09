unit AWS4Delphi.S3;

interface

uses
  AWS4Delphi.Interfaces,
  AWS4Delphi.Model.S3;

type
  //Signature DLL
  TSendFile = function(aJSONParameters: PAnsiChar): PAnsiChar; stdcall;
  TSendFileMP = function(aJSONParameters: PAnsiChar): PAnsiChar; stdcall;

  TAmazonS3 = class(TInterfacedObject, ISendS3)
    private
      FS3: TS3;

      constructor Create;
    public
      class function New: ISendS3;
      destructor Destroy; override;

      function SetFilePath(const aFilePath: String): ISendS3;
      function SetRegion(const aRegion: String): ISendS3;
      function SetBucketName(const aBucketName: String): ISendS3;

      procedure SendFile(var aResult: String);
      procedure SendFileMP(var aResult: String);
  end;

implementation

{ TAmazonS3 }

uses
  AWS4Delphi.Constants,
  Winapi.Windows,
  System.SysUtils;

constructor TAmazonS3.Create;
begin
  FS3 := TS3.Create;
end;

destructor TAmazonS3.Destroy;
begin
  FreeAndNil(FS3);
  inherited;
end;

class function TAmazonS3.New: ISendS3;
begin
  Result := Self.Create;
end;

procedure TAmazonS3.SendFile(var aResult: String);
var
  xHandle: THandle;
  xSendFile: TSendFile;
begin
  aResult := '';

  xHandle := LoadLibrary(NAME_DLL);

  if xHandle > 0 then
  begin
    try
      @xSendFile := GetProcAddress(xHandle, 'SendFile'); //Method name of dll

      if @xSendFile <> nil then
      begin
        try
          aResult := xSendFile(PAnsiChar(AnsiString(FS3.JSONParameters)));
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

procedure TAmazonS3.SendFileMP(var aResult: String);
var
  xHandle: THandle;
  xSendFileMP: TSendFileMP;
begin
  aResult := '';

  xHandle := LoadLibrary(NAME_DLL);

  if xHandle > 0 then
  begin
    try
      @xSendFileMP := GetProcAddress(xHandle, 'SendFileMP'); //Method name of dll

      if @xSendFileMP <> nil then
      begin
        try
          aResult := xSendFileMP(PAnsiChar(AnsiString(FS3.JSONParameters)));
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

function TAmazonS3.SetBucketName(const aBucketName: String): ISendS3;
begin
  FS3.BucketName := aBucketName;
  Result := Self;
end;

function TAmazonS3.SetFilePath(const aFilePath: String): ISendS3;
begin
  FS3.FilePath := aFilePath;
  Result := Self;
end;

function TAmazonS3.SetRegion(const aRegion: String): ISendS3;
begin
  FS3.RegionAWS := aRegion;
  Result := Self;
end;

end.

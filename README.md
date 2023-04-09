# AWS4Delphi

[![NPM](https://img.shields.io/github/license/armandocorrea/AWS4Delphi?style=plastic)](https://github.com/armandocorrea/AWS4Delphi/blob/master/LICENSE)

# Sobre o projeto

O AWS4Delphi é um componente que possui alguns recursos de integração com os serviços da Amazon Web Services. É um componente desenvolvido para o Delphi.

## Serviços

![Services](https://github.com/armandocorrea/AWS4Delphi/blob/master/img/Servi%C3%A7os.png)

## Sample

![Sample](https://github.com/armandocorrea/AWS4Delphi/blob/master/img/Sample.png)

# Como utilizar o componente

```bash
# Passo 1: Adicionar no library path a pasta src
# Passo 2: Criar duas variáveis de ambiente de nível usuário (Windows):
TOKEN_AWS: {seu_token_aws}
SECRET_AWS {seu_secret_aws}
Obs.: Chaves criadas no console da AWS na página IAM (Identity and Access Management)
Na política dessa chave terá que dar permissão aos recursos: ses, s3, sns e mobiletargeting
# Passo 3: Na pasta do executável da sua aplicação adicionar as bibliotecas abaixo (ambas encontradas em samples\Files):
- AWS4Delphi.dll
- AWSSDK.Core.dll
- AWSSDK.Pinpoint.dll
- AWSSDK.S3.dll
- AWSSDK.SimpleEmail.dll
- MimeKit.dll
- Newtonsoft.Json.dll
- System.Memory.dll
- System.Runtime.CompilerServices.Unsafe.dll
```

```delphi
#Exemplo SMS
begin
   TAmazonPinpoint.New
      .SetPhoneNumber(lstDestinations.Items)
      .SetMessage(Trim(edtMessage.Text))
      .SetRegion(Trim(edtRegion.Text))
      .SetAppId(Trim(edtAppId.Text))
      .SendSMS(xResult);
end;    
    
#Exemplo S3
begin
   TAmazonS3.New
      .SetFilePath(Trim(edtFilePath.Text))
      .SetRegion(Trim(edtRegionS3.Text))
      .SetBucketName(Trim(edtBucketName.Text))
      .SendFile(xResult);
end;    
    
#Exemplo Email
begin
  TAmazonEmail.New
      .SetRegion(Trim(edtRegionAWSEmail.Text))
      .SetEmailSender(Trim(edtEmailSender.Text))
      .SetRecipient(lstRecipient.Items)
      .SetSubject(Trim(edtSubject.Text))
      .SetMessageBody(Trim(edtMessageEmail.Text))
      .SetFilePath(lstFilePath.Items)
      .SendEmailWithFile(xResult);    
end;      
```

# Tecnologias Utilizadas
## Componente
- Delphi 10.4.2 - Sydney
## DLL AWS4Delphi
- C#
## Recursos
- Programação Funcional
- Orientação a Objetos
- Comunicação com DLL

# Como contribuir
- Fique a vontade para contribuir com o projeto.
- Basta realizar o fork do projeto, evoluir/melhorar e solicitar um Pull Request.

# Autor
https://www.linkedin.com/in/armandochneto/

http://www.armandoneto.dev.br/

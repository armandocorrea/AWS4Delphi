using Amazon;
using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;
using AWS4Delphi.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;

namespace AWS4Delphi.S3
{
    class ServiceS3
    {
        public static string SendFile(string aJSONParameters)
        {
            try
            {
                //Environment Variables
                string xAccessToken = Environment.GetEnvironmentVariable("TOKEN_AWS", EnvironmentVariableTarget.User);
                string xSecretToken = Environment.GetEnvironmentVariable("SECRET_AWS", EnvironmentVariableTarget.User);

                InputParametersS3 inputParametersS3 = JsonConvert.DeserializeObject<InputParametersS3>(aJSONParameters);

                DadosS3 dadosS3 = new DadosS3();
                var awsCredentials = new Amazon.Runtime.BasicAWSCredentials(xAccessToken, xSecretToken);

                dadosS3.client = new AmazonS3Client(awsCredentials, RegionEndpoint.GetBySystemName(inputParametersS3.RegionAWS));

                dadosS3.request = new PutObjectRequest()
                {
                    BucketName = inputParametersS3.BucketName,
                    FilePath = inputParametersS3.FilePath                    
                };                               

                dadosS3.response = dadosS3.client.PutObject(dadosS3.request);
                dadosS3.result   = dadosS3.response.HttpStatusCode.ToString();

                return dadosS3.result;
            }
            catch (AmazonS3Exception ex)
            {
                return ex.Message;
            }
            catch (AmazonServiceException ex)
            {
                return ex.Message;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }        
        }

        public static string SendFileMP(string aJSONParameters)
        {
            try
            {
                //Environment Variables
                string xAccessToken = Environment.GetEnvironmentVariable("TOKEN_AWS", EnvironmentVariableTarget.User);
                string xSecretToken = Environment.GetEnvironmentVariable("SECRET_AWS", EnvironmentVariableTarget.User);

                InputParametersS3 inputParametersS3 = JsonConvert.DeserializeObject<InputParametersS3>(aJSONParameters);                               

                DadosS3 dadosS3 = new DadosS3();
                var awsCredentials = new Amazon.Runtime.BasicAWSCredentials(xAccessToken, xSecretToken);

                dadosS3.s3 = new AmazonS3Client(awsCredentials, RegionEndpoint.GetBySystemName(inputParametersS3.RegionAWS));
                dadosS3.inputParameters = inputParametersS3;

                dadosS3.uploadRequest = new InitiateMultipartUploadRequest
                {
                    BucketName = inputParametersS3.BucketName,
                    Key = Path.GetFileName(inputParametersS3.FilePath)
                };                                

                UploadObjectAsync(dadosS3).Wait();

                return dadosS3.result;
            }
            catch (AmazonS3Exception ex)
            {
                return ex.Message;
            }
            catch (AmazonServiceException ex)
            {
                return ex.Message;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        private static async Task UploadObjectAsync(DadosS3 dadosS3)
        {
            // Criar lista para gravar as partes de respostas de envio.
            List<UploadPartResponse> uploadResponses = new List<UploadPartResponse>();

            // Inicia o Envio.
            InitiateMultipartUploadResponse initResponse =
                await dadosS3.s3.InitiateMultipartUploadAsync(dadosS3.uploadRequest);

            // Parte para enviar.
            long contentLength = new FileInfo(dadosS3.inputParameters.FilePath).Length;
            long partSize = 5 * (long)Math.Pow(2, 20); // 5 MB

            try
            {
                long filePosition = 0;
                for (int i = 1; filePosition < contentLength; i++)
                {
                    UploadPartRequest uploadRequest = new UploadPartRequest
                    {
                        BucketName = dadosS3.inputParameters.BucketName,
                        Key = Path.GetFileName(dadosS3.inputParameters.FilePath),
                        UploadId = initResponse.UploadId,
                        PartNumber = i,
                        PartSize = partSize,
                        FilePosition = filePosition,
                        FilePath = dadosS3.inputParameters.FilePath                        
                    };

                    // Envia a parte e adiciona a resposta na nossa lista.
                    uploadResponses.Add(await dadosS3.s3.UploadPartAsync(uploadRequest));

                    filePosition += partSize;
                }

                // Configurar para completar o Envio.
                CompleteMultipartUploadRequest completeRequest = new CompleteMultipartUploadRequest
                {
                    BucketName = dadosS3.inputParameters.BucketName,
                    Key = Path.GetFileName(dadosS3.inputParameters.FilePath),
                    UploadId = initResponse.UploadId                    
                };
                completeRequest.AddPartETags(uploadResponses);

                // Finalizar o Envio.
                CompleteMultipartUploadResponse completeUploadResponse =
                    await dadosS3.s3.CompleteMultipartUploadAsync(completeRequest);

                dadosS3.result = completeUploadResponse.HttpStatusCode.ToString();
            }
            catch (Exception ex)
            {
                // Abortar o Envio.
                AbortMultipartUploadRequest abortMPURequest = new AbortMultipartUploadRequest
                {
                    BucketName = dadosS3.inputParameters.BucketName,
                    Key = Path.GetFileName(dadosS3.inputParameters.FilePath),
                    UploadId = initResponse.UploadId
                };
                await dadosS3.s3.AbortMultipartUploadAsync(abortMPURequest);

                dadosS3.result = ex.Message;
            }
        }
    }
}

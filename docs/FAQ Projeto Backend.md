FAQ - Projeto Back-end (Disciplina de Projetos) 
1. Escolhi a trilha Back-end. Preciso fazer Front-end ou testes avançados 
também? 
Não obrigatoriamente. O foco principal do seu projeto é o Back-end, incluindo 
lógica de negócio, banco de dados, autenticação, segurança (LGPD), logs, e rotas 
(endpoints). 
No entanto, você precisa demonstrar minimamente que seu back-end funciona. 
Para isso, é suficiente apresentar testes básicos usando ferramentas como 
Postman ou Insomnia, não sendo necessário desenvolver uma interface web 
completa, com html/css e framewoks avançadas, apenas uma página simples. 
Exemplo simples de teste (POSTMAN): 
• Endpoint: POST /pacientes 
{ 
"nome": 
"João 
"cpf": 
Silva", 
"12345678900" 
} 
• Resposta Esperada: 
{ 
"id": 
"nome": 
1, 
"João 
Silva", 
"cpf": 
"12345678900" 
} 
2. Quais requisitos funcionais e não funcionais devo atender? 
Você deve descrever todos os requisitos essenciais (funcionais e não funcionais) 
listados no estudo de caso (ex.: cadastro de pacientes, autenticação, segurança 
etc). Porém, não é obrigatório implementar todos em profundidade, desde que você 
indique claramente quais você escolheu priorizar e desenvolver, o seu foco está no 
backend. 
3. Preciso implementar Telemedicina e videochamada? 
A Telemedicina é um dos requisitos sugeridos no estudo de caso, mas não 
obrigatória para implementação integral. Seu foco principal está nos requisitos 
essenciais, como autenticação e CRUD de pacientes. Não é importante como irá 
ocorrer a videochamada. 
4. É necessário implementar autenticação (login/sign-up)? 
Sim, autenticação é uma prática essencial. No contexto do projeto (LGPD e 
segurança), é praticamente obrigatório implementar minimamente um sistema 
seguro de login/sign-up. 
Exemplo simples de autenticação: 
Endpoint: 
POST 
/login 
{ 
"email": 
"usuario@email.com", 
"senha": 
"senha123" 
} 
• Resposta Esperada: 
{ 
"token": 
} 
"eyJhbGciOiJIUzI1NiIsIn..." 
5. Posso entregar o código em prints ou devo colocá-lo integralmente no PDF? 
Não é recomendável colocar todo o código integralmente no PDF, pois pode deixá
lo muito extenso. O ideal é apresentar trechos essenciais e o restante do código 
completo disponibilizado em um repositório Git (GitHub, GitLab). 
No PDF: 
• Insira pequenos trechos exemplares. 
• Forneça o link do repositório completo. 
6. Como estruturar meu documento PDF? 
Use esta estrutura básica, adaptável às normas ABNT (disponíveis na biblioteca 
virtual do AVA): 
• Capa 
• Sumário 
• Introdução 
• Requisitos Funcionais e Não Funcionais 
• Modelagem (Casos de Uso, Diagrama de Classes ou DER) 
• Implementação (Endpoints, arquitetura, trechos de código, link do Git) 
• Plano de Testes (mínimo obrigatório, testes básicos com Postman) 
• Conclusão 
• Referências 
• Anexos (opcional) 
Você pode adaptar o modelo usado na Atividade Extensionista anterior. 
7. Existe um documento padrão (Word) ou modelo disponibilizado? 
Não é disponibilizado um documento modelo (Word). Você deverá criar seu 
documento usando as normas da ABNT e a estrutura citada acima. O documento 
f
 inal deve ser exportado em PDF. 
8. Devo fazer deploy da API ou apenas fornecer o link do Git? 
Não é obrigatório realizar o deploy público da sua aplicação. É suficiente 
disponibilizar seu projeto completo em um repositório Git público (GitHub, GitLab 
etc.) e fornecer o link no documento PDF. 
Dica: certifique-se de que seu repositório está público e contém instruções claras 
(README) sobre como rodar sua aplicação. 
9. Preciso criar uma documentação detalhada dos endpoints? 
Sim. A documentação dos endpoints é obrigatória e deve descrever claramente: 
• Método HTTP (GET, POST, PUT, DELETE) 
• URL da rota 
• Parâmetros e estruturas JSON 
• Respostas esperadas e códigos HTTP 
Exemplo de documentação de endpoint: 
• Endpoint: GET /pacientes 
• Objetivo: Listar todos os pacientes cadastrados 
• Resposta: 
[ 
{"id":1, "nome":"João Silva", "cpf":"12345678900"}, 
{"id":2, "nome":"Maria Oliveira", "cpf":"09876543211"} 
] 
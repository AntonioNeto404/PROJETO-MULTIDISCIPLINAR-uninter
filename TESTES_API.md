# 🧪 TESTES DA API VIDAPLUS

## 1. Teste de Status da API
```bash
GET http://localhost:3333/
```

**Resultado Esperado:**
```json
{
    "apiStatus": "OK",
    "prisma": "Connected"
}
```

## 2. Registro de Administrador
```bash
POST http://localhost:3333/admin/register
Content-Type: application/json

{
    "nome": "Admin VidaPlus",
    "email": "admin@vidaplus.com",
    "senha": "senha123",
    "confirmaSenha": "senha123",
    "perfil": "Administrador"
}
```

**Resultado Esperado:**
```json
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

## 3. Login de Administrador
```bash
POST http://localhost:3333/admin/login
Content-Type: application/json

{
    "email": "admin@vidaplus.com",
    "senha": "senha123"
}
```

## 4. Cadastro de Unidade Hospitalar
```bash
POST http://localhost:3333/hospital/register
Authorization: Bearer [TOKEN_DO_ADMIN]
Content-Type: application/json

{
    "nome": "Hospital Central VidaPlus",
    "endereco": "Rua das Flores, 123",
    "telefone": "(11) 9999-9999",
    "capacidade": 100,
    "tipo": "Hospital"
}
```

## 5. Cadastro de Paciente
```bash
POST http://localhost:3333/pacientes/register
Authorization: Bearer [TOKEN_DO_ADMIN]
Content-Type: application/json

{
    "nome": "João Silva Santos",
    "cpf": "12345678900",
    "email": "joao@email.com",
    "telefone": "(11) 88888-8888",
    "dataNascimento": "1990-01-15T00:00:00.000Z",
    "genero": "Masculino",
    "unidadeId": "[ID_DA_UNIDADE]"
}
```

## 6. Teste de Segurança (Sem Token)
```bash
GET http://localhost:3333/pacientes
# Sem header Authorization
```

**Resultado Esperado:**
```json
{
    "msg": "Token não fornecido"
}
```
Status: 401 Unauthorized

# Assembly x86-64 — AMD Ryzen (Arquitetura Zen)

Trabalho final de Arquitetura de Computadores — IFPR Campus Colombo.

Dois programas em Assembly x86-64 (NASM, syscalls Linux), demonstrando na prática os conceitos da arquitetura Zen/x86-64 estudados na pesquisa: registradores, modos de endereçamento, operações aritméticas, lógicas, de comparação e de desvio.

## Programas

### `soma.asm` — Soma de dois números inteiros

Soma dois valores fixos (15 + 27) usando o registrador `RAX` como acumulador, converte o resultado de inteiro para string decimal (ASCII) e imprime no terminal via syscall `write`.

**Conceitos demonstrados:** transferência de dados (`mov`, `lea`), aritmética (`add`), divisão (`div`) para conversão decimal, comparação/desvio (`test`/`jnz`) no loop de conversão.

**Saída esperada:**
```
Resultado da soma: 42
```

### `contagem.asm` — Geração de contagem

Imprime os números de 1 a 10, um por linha, usando um loop controlado por comparação e desvio condicional.

**Conceitos demonstrados:** uso de registrador dedicado ao contador (`R13`, preservado entre syscalls), comparação (`cmp`), desvio condicional (`jg`) e incondicional (`jmp`), incremento (`inc`).

**Saída esperada:**
```
1
2
3
4
5
6
7
8
9
10
```

## Por que `R12`/`R13` e não `RAX`/`RDX`/etc?

As syscalls do Linux (`write`, `exit`) e a instrução `div` sobrescrevem `RAX`, `RDI`, `RSI`, `RDX` e `RCX`. Por isso o contador (`contagem.asm`) e o ponteiro pro início da string convertida (em ambos os programas) ficam guardados em `R12`/`R13` — registradores que nenhuma dessas operações toca, evitando que o valor seja perdido entre uma syscall e outra.

## Ambiente necessário

Os programas usam **syscalls Linux x86-64** diretamente (sem libc), então precisam rodar em um ambiente Linux real. Em Windows, a forma mais simples é via **WSL (Windows Subsystem for Linux)**.

### 1. Instalar o WSL (caso ainda não tenha)

No PowerShell como Administrador:
```powershell
wsl --install
```
Reinicie o PC, abra o app "Ubuntu" e crie usuário/senha quando solicitado.

### 2. Instalar as ferramentas dentro do Ubuntu (WSL)

```bash
sudo apt update
sudo apt install nasm binutils -y
```

Confirme a instalação:
```bash
nasm -v
ld --version
```

### 3. Baixar/clonar este repositório

```bash
git clone https://github.com/UltimateStrength/ads-adc-ryzen-architecture-in-assembly.git
cd ads-adc-ryzen-architecture-in-assembly
```

## Como compilar e executar

**Importante:** monte e execute dentro do terminal WSL (Ubuntu) — não no PowerShell/CMD do Windows, já que `nasm`/`ld` instalados no WSL não são visíveis para o Windows.

### Soma de dois números

```bash
nasm -f elf64 soma.asm -o soma.o
ld soma.o -o soma
./soma
```

### Geração de contagem

```bash
nasm -f elf64 contagem.asm -o contagem.o
ld contagem.o -o contagem
./contagem
```

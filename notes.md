#### 24/08/2023

Curso de IOS: autenticação, GPS e mais recursos nativos

@01-Salvando arquivos local

@@01
Apresentação

[00:00] Olá, boas-vindas, eu sou o Ândriu e esse é o curso de frameworks nativos para iOS, onde nós vamos dar continuidade a uma série de cursos que nós já estamos vendo sobre frameworks nativos. Nós temos aqui o app Alura Ponto, onde nós conseguimos registrar ponto.
[00:19] Ou seja, o horário que um funcionário trabalha. Eu posso aqui registrar um ponto e eu tenho aqui os recibos com todos os horários que eu trabalhei.

[00:30] A ideia desse curso é continuar as implementações, então nós vamos começar falando um pouco sobre armazenamento com o File Manager. No curso anterior, nós falamos um pouco sobre o core data, e agora nós vamos falar um pouco sobre o File Manager, como persistimos, por exemplo, essa foto de perfil local, utilizando o File Manager.

[00:53] Depois nós vamos seguir com outro recurso bem interessante, que é a autenticação local, que também é nativa do iOS. No nosso caso, ao deletar um recibo - se eu clicar nesse "X", ele pede que eu faça a autenticação para conseguir apagar esse recibo. Esse recurso é muito utilizado em aplicativos de banco ou aplicativos que exigem uma identificação do usuário para fazer alguma ação, e vamos aprender através de deletar um recibo.

[01:34] Depois nós vamos falar um pouco sobre localização, vamos aprender um pouco sobre core location, como podemos trackear a localização do usuário. E depois vamos falar também sobre o map kit, com o mapa da Apple. A ideia então é ao bater um ponto, registrarmos a latitude e longitude do usuário para conseguirmos exibir onde foi registrado o ponto. Então vamos trabalhar com o mapa do iOS.

[02:03] Por último vamos falar um pouco sobre os quick actions, sobre o shortcut do iOS, então eu posso clicar e segurar e nós temos essa opção "Registrar ponto".

[02:16] Nada mais é do que um atalho para o nosso aplicativo, então conseguimos também utilizar atalhos no nosso app de forma nativa. Esse é o conteúdo que nós vamos ver durante esse curso e eu espero você.

@@02
Projeto inicial

Para iniciar o curso, faça o download do projeto.
Bons estudos!

https://github.com/alura-cursos/2315-Alura-Ponto/archive/a917e2084b18daf03f9335e6722bc8650c7daca8.zip

@@03
Salvando arquivo com File Manager

[00:00] Estamos iniciando então mais um curso da nossa série de frameworks nativos para iOS. Então nós já iniciamos algumas implementações no primeiro curso, onde nós aprendemos a persistir informações com o core data, aprendemos a utilizar a câmera, a biblioteca de imagens. A ideia é continuarmos utilizando o mesmo projeto, que é Alura Ponto, um aplicativo para registrar o horário de trabalho do funcionário.
[00:28] Então a hora que ele começa, a hora que vai almoçar, a hora que ele volta do almoço e a hora que ele termina de trabalhar. A ideia é registrar todos esses horários no aplicativo. No curso passado nós aprendemos então a persistir algumas coisas com o core data, quando nós batemos ponto nós já temos essas informações salvas, local, e temos aqui uma imagem de perfil que ainda nós não tratamos desse caso.

[00:59] Quando eu clico para escolher uma foto, por exemplo, na verdade, é a foto de perfil do usuário, se eu fechar o aplicativo e rodar ele de novo, nós perdemos essa informação. Clico para ir para o perfil, eu não tenho mais a imagem.

[01:18] Isso foi proposital, porque vamos utilizar outra maneira de trabalhar com persistência local no iOS, que é o File Manager, o gerenciador de arquivos. Nós aprendemos a trabalhar com o core data, nós temos também o File Manager, temos outras bibliotecas, como o user defaults para preferências do usuário, enfim, mas com certeza o File Manager também é muito utilizado para persistir esporadicamente algum arquivo que você precise.

[01:54] Alguns cuidados que nós devemos ter é em relação ao tamanho dos arquivos que nós estamos armazenando com o File Manager, então fotos muito pesadas, em grande quantidade, se você precisar fazer algumas consultas mais rápidas no aplicativo, então é melhor você trabalhar com o core data ao invés do File Manager, porque ele é muito mais seguro e as consultas também são muito mais rápidas.

[02:20] Mas, o File Manager, é muito importante termos esse conhecimento, porque quando você precisar persistir, esporadicamente, alguma coisa, você pode optar por esse recurso também. Então vamos lá, o que vamos começar a fazer? Vamos começar a trabalhar com o File Manager, o nosso gerenciador de arquivos, e vamos entender como salvar e como ler essa imagem através do File Manager.

[02:45] Para começar, nós temos a nossa pasta "Model", onde nós temos já algumas classes: "Camera", "Recibo", "FormatadorDeData". Vamos criar um novo arquivo, botão direito em cima da pasta, novo arquivo, eu vou manter a opção "Swift File" mesmo, vou dar um "Next" e eu vou criar a classe chamada "Perfil". Vou dar um "Create". Vou criar aqui a classe.

[03:13] class Perfil {}. Nós vamos ter aqui um método chamado func salvarImagem(), onde nós vamos receber, por parâmetro, a ( imagem: ), nós selecionamos da biblioteca de imagens do iOS. Ela é um ( imagem: UIIMage) {}. Nós não temos acesso às coisas do UIkit, porque estamos com o foundation.

[03:39] Quando eu importo o UIkit automaticamente eu importo também o foundation, então agora eu posso utilizar o UIImage que nós precisamos persistir. Eu vou começar criando uma constante, porque a ideia aqui, para conseguirmos salvar essa imagem, é acessarmos o diretório de pastas interno do nosso aplicativo.

[04:02] Então todo aplicativo, quando nós buildamos ele no simulador, ele cria algumas pastas e podemos utilizar essas pastas para salvar os nossos arquivos. É como se criássemos uma pasta realmente aqui, no finder, eu tenho algumas pastas do curso. Quando eu abro, por exemplo, o terminal, se eu quiser entrar em alguma pasta, eu posso clicar e arrastar a pasta para o terminal e repare que eu tenho o endereço desta pasta.

[04:32] Na "/Users/andriucoelho/Documents/alura-ponto-parte2", eu tenho aqui um path, um diretório. É esse diretório que precisamos acessar para conseguirmos criar a nossa pasta e salvar as coisas dentro. Vamos lá, vou fechar aqui. Eu vou criar uma constante chamada let diretorio =, ela é igual ao = FileManager.default.urls().

[05:01] Eu vou pegar esse primeiro método mesmo, onde nós precisamos apontar algumas configurações. A primeira é o tipo que eu quero acessar, o tipo da pasta que eu quero acessar. Eu quero acessar a pasta de documentos, então é (for: .documentDirectory,. Esse in, na verdade, também é o tipo de pasta de permissão que eu quero acessar, então é esse in: .userDomainMask).

[05:28] Ele retorna uma lista, então vou pegar a primeira dessa lista, ).first, o primeiro path. Isso, na verdade, ele ficou opcional, repare que ele é uma URL opcional, só para desembrulhar essa linha com segurança, vou utilizar aqui o guard let, se ele não conseguir, eu dou um .first else {return} aqui no final.

[05:52] Próximo passo, precisamos colocar um nome para essa foto que vamos salvar, let nomeDaFoto = " ", que você pode colocar qualquer coisa, eu vou colocar "perfil.png". Depois disso, o que precisamos fazer? Precisamos montar a URL, repare que temos o endereço da pasta, mas precisamos concatenar com o nome da foto.

[06:16] É isso que vamos fazer, pegar esse diretório, na verdade, uma barra, e perfil.png. Como eu faço isso? Eu vou utilizar o appending path, só que eu vou criar uma constante, eu vou chamar de let urlDoArquivo =. Eu vou utilizar aqui o diretório que eu criei e vou dar um = diretorio.appendingPathComponent()e eu passo o (nomeDaFoto).

[06:45] Já temos a nossa URL, com o diretório mais o nome da foto. Agora precisamos pegar essa imagem, que é um UIImage, e precisamos converter isso para binário, porque não salvamos um UIImage, nós salvamos os arquivos em bytes, e é isso que vamos fazer. Outra coisa que precisamos também fazer é uma verificação, para verificar se a foto já existe.

[07:17] Por exemplo, se eu seleciono uma foto e depois eu quero trocar, eu preciso saber se essa foto já existe, para apagar antiga e salvar a nova foto. Vamos lá, como eu faço para verificar se já existe uma foto com esse nome? Eu vou utilizar também o File Manager, vou criar aqui uma verificação, if FileManager.default., eu vou utilizar esse .fileExists(), onde eu passo o path.

[07:45] O path eu já tenho, que é a URL do arquivo, ponto path, porque ele está esperando uma string, se eu passar só a URL do arquivo, ele é do tipo URL, por isso eu dou um path, (atPath: urlDoArquivo.path) {}. Se isso for verdadeiro, ele cai aqui dentro desse if. O que eu vou fazer aqui?

[08:05] Eu vou então remover a foto. //remover a foto, já vamos ver como remover. Feita a verificação, depois disso eu posso então, de fato, salvar a minha imagem. Como eu salvo? Primeiro eu vou criar uma nova constante, que é, na verdade, a imagem, mas em outro formato, guard let imagemData =- data não de data de dia, data de dados.

[08:41] O que eu tentarei fazer aqui? Eu tentarei converter isso. Eu tenho um método que se chama = imagem.jpegData(), onde eu passo, na verdade, de 0 a 1 qual a qualidade que eu quero salvar. Nesse caso, como é uma única foto, eu vou colocar (compressionQuality: 1) else. Se eu não conseguir fazer essa conversão, eu também dou um else {return}.

[09:07] Com a imagem aqui, agora sim, eu vou utilizar o método onde vamos salvar, que é o seguinte, eu vou pegar a imagem e eu vou chamar esse método do { imagemData.write(to: )} catch {}, onde eu passo uma URL, ou seja, eu vou escrever, eu vou salvar, eu vou persistir isso em algum lugar. Qual é o lugar?

[09:31] Nós já temos a URL do arquivo, então vou passar aqui (to: urlDoArquivo). Caso eu não consiga, eu precisarei saber qual foi o erro. EU vou dar um try imagemData, porque é uma throw function. Se não der certo, vamos verificar o que aconteceu.

[09:52] Então nós já temos aqui um método onde nós estamos salvando a nossa imagem. Relembrando, primeiro precisamos do acesso ao local onde será salva essa foto, depois nós precisamos de fato criar o nome de uma foto e concatenar essa URL. E precisamos verificar se essa foto já existe, se já existir, apagamos a antiga e salvamos a nova.

[10:22] Se não existir vamos então salvar a imagem. Agora precisamos ver como vamos remover a foto, e vamos ver isso no próximo vídeo.

@@04
Removendo arquivo

[00:00] Continuando, então faltou removermos a foto, caso ela exista. Para não ficar muito misturado, porque, na verdade, esse método é para salvar a imagem e não para remover, eu vou criar aqui um método que será especificamente para remover uma foto. private func removerImagemAntiga() e eu vou pegar aqui, vou pedir para o parâmetro a URL em forma de string, ( url: String) {}.
[00:31] Dessa maneira nós não colocamos aqui a implementação de remover. Vamos passar então a URL, que é a URL do arquivo, removerImagemAntiga(urlDoArquivo.path), para ele retornar como string, porque só URL do arquivo é do tipo URL. Nós precisamos dela como string, por isso o .path.

[00:52] Aqui embaixo, nós vamos, na verdade, utilizar o FileManager.default.remove, e temos dois métodos parecidos, um é at e o outro é at path. Como nós estamos trabalhando com string, vamos utilizar esse (atPath: url) e vamos passar a URL. Ele vai reclamar aqui porque esse método .removeItem(atPath é uma throw function, ou seja, é um método que pode disparar uma exceção.

[01:30] Todos os métodos que tem essa assinatura do throw function, nós precisamos fazer uma verificação, na verdade, e tratar isso, porque pode ser que ele devolva um erro e nós podemos manipular esse erro. A maneira mais feia e perigosa de se trabalhar é colocar o try! FileManager forçado e deixar o método assim.

[01:57] Isso é ruim, porque pode ser que ele dispare um erro e o seu aplicativo vai dar crash e você não vai saber o que está acontecendo. Então evite trabalhar dessa forma. Nós vamos trabalhar dessa outra, que é mais segura, utilizando o do, catch, aqui é catch let error e vamos colocar todo esse código no do. Então ele vai tentar fazer esse comando, se ele não conseguir, ele vai estourar o erro e podemos verificar qual foi o erro.

[02:36] No seu projeto, se você quiser, você pode colocar, por exemplo, um UI alert controller para mostrar uma mensagem para o usuário, caso dispare algum erro, vai da forma que você quer tratar os erros no seu app. Já temos aqui o removerImagemAntiga, já estamos chamando ele no código.

[02:59] Agora o que precisamos fazer, de fato, é chamar esse método salvarImagem. Nós vamos no "ReciboViewController", aqui tem o método de delegate da câmera, que ele dispara ao escolher uma foto, que é esse método didSelectFoto.

[03:18] Então quando eu seleciono uma foto da biblioteca, ele cai aqui dentro desse código. O que vamos fazer aqui? Eu vou chamar a classe que nós criamos, que é classe Perfil()., e eu vou chamar esse método ().salvarImagem(image), onde eu passo a imagem que eu selecionei na biblioteca.

[03:34] Agora já podemos testar. Qual é o teste que eu vou fazer? Primeiro vamos verificar se a imagem realmente está sendo salva. Porém, como nós ainda não implementamos o método para recuperar essa imagem, nós só estamos salvando, só vamos colocar alguns breakpoints no nosso código.

[03:56] Breakpoint nada mais é do que um ponto onde o nosso programa vai parar a execução e conseguimos inspecionar o valor de algumas variáveis, ver se ele entra no if ou no else, nós conseguimos ver, de fato, o que está acontecendo. Então primeiro eu vou colocar um breakpoint na linha 18, onde ele vai verificar se a imagem existe.

[04:20] Eu vou colocar um outro breakpoint na linha 32, para ver se essa tentativa de remover a imagem está dando certo ou se está caindo no erro. A mesma coisa na linha 24, eu vou verificar se ele está conseguindo salvar a imagem ou se está estourando algum erro. Quando eu rodar o programa vai ficar um pouco mais fácil de entender o porquê desses breakpoints, você verá que eles são bem úteis para debug.

[04:50] No app, cliquei em "Recibos", cliquei onde selecionamos a foto de perfil, biblioteca de fotos, vou escolher a cachoeira, "Escolher". Olha só, o programa parou na linha 18, repare que tem uma linha verde.

[5:09] É exatamente no meu breakpoint, então breakpoint nada mais é do que essa figura azul, onde nós clicamos e ele para o nosso código. O que eu posso fazer agora? Eu vou remover toda essa mensagem para conseguirmos ver o valor de uma variável, caso precisemos, mas o mais importante são esses botões aqui embaixo.

[05:38] No símbolo de play eu solto a execução, então ele parou, se eu clicar nesse ícone ele vai continuar a execução e cair no próximo breakpoint, se houver. Esse próximo botão, esse step over, ele vai para a linha debaixo. No botão que é uma seta para baixo, ele entra no método para verificar o valor das variáveis.

[05:57] Nós vamos utilizar agora o step over, que é essa seta, o quarto botão. O que eu vou fazer? Eu vou verificar se ele vai entrar nessa linha 19 ou se ele já vai para a linha 22. Cliquei no step over, ele já foi para a linha 22, significa que ainda não existe nenhuma foto antiga, nós ainda não salvamos nenhuma foto.

[06:19] Vou clicar mais uma vez para ir para a linha debaixo e aqui é onde nos interessa, a linha 25, ele vai tentar escrever, ele vai tentar salvar essa foto. Se essa linha verde vier para a linha 27, ou seja, se ele cair nesse print(error), significa que ocorreu algum erro, então fizemos alguma coisa errada.

[06:43] Se ele não passar por aqui, significa que a foto está salva. Eu vou mais uma vez clicar nesse botão do step over e ele não entrou na linha 27, ele já veio direto para baixo.

[06:56] Isso é muito bom. Porém, se eu vier no simulador, repare que a execução está toda travada, não consigo clicar em lugar nenhum, porque o meu breakpoint ainda está ativo. Como eu continuo a execução do meu programa? Através desse botão de play, "Continue program execution".

[07:16] Clico nesse botão, ele vai soltar todos os breakpoints. É bem importante, porque às vezes você coloca um breakpoint, ele fica preso e você não sabe como continua a execução. Legal, já estamos salvando a imagem, já está funcionando.

[07:35] Para finalizar então vou remover esses breakpoints. Como eu removo? Eu clico nele, seguro e arrasto para fora, clico e arrasto para direita em todos. Nós já asseguramos que a imagem está sendo salva. A seguir vamos implementar o método para recuperar essa imagem e setar no nosso outlet.

@@05
Recuperando arquivo

[00:00] Agora que nós já estamos salvando a imagem, através do File Manager, é hora de recuperarmos essa imagem para conseguirmos utilizar no view controller de recibo, utilizar no nosso outlet. O que eu vou fazer aqui? Eu vou criar um novo método, eu vou chamar de func carregarImagem() ->, na assinatura do método não terá nada e vamos devolver um -> UIImage? opcional.
[00:28] Basicamente o que nós precisamos fazer aqui é o caminho inverso que nós fizemos para salvar. Nós precisamos acessar o endereço onde está a imagem e converter essa imagem para UI image novamente. Para isso, vamos utilizar o NS search ref. Eu vou criar aqui uma constante, chamada let diretorio.

[00:58] Na verdade, let urlDoArquivo =, e eu vou utilizar esse método NSSearchPathForDirectoriesInDoamins(). Aqui nós precisamos passar alguns parâmetros, que vamos ver passo a passo para que serve cada um, mas basicamente é o diretório, então para salvar aqui nós utilizamos esse diretório do .documentDirectory.

[01:28] O segundo parâmetro que nós temos é esse domainMask, que também nós utilizamos aqui em cima, então nós precisamos utilizar esse mesmo tipo, .userDomainMask, que foi esse outro parâmetro que nós criamos para montar esse diretório. Por último, aqui tem a ver com a URL, se queremos comprimir a URL, com aquele til, ou se queremos mostrar a URL completa.

[02:00] Então precisamos montar esses parâmetros, para não ficar muito grande a chamada desse método eu vou quebrar em algumas constantes. A primeira que vamos criar é o diretório, que é utilizando let diretorio = FileManager e aqui nós temos essa opção do search path directory e do search path domain mask.

[02:21] A primeira que nós vamos utilizar é esse = FileManager.SearchPathDirectory. e vamos chamar o .documentDirectory, exatamente como nós fizemos aqui em cima. O próximo passo então, nós precisamos desse user domain mask, então vamos criar uma constante let userDomainMask =, que também nós vamos utilizar o = FileManager., esse método = FileManager.SearchPathDirectory..

[02:55] Só que agora, o invés de document directory, nós vamos utilizar o .userDirectory. Na verdade, é esse = FileManager.SearchPathDomainMask. e aqui utilizamos o .userDomainMask. São parecidos. Com o diretório e com esse userDomainMask nós já podemos utilizar nesse método aqui de baixo, da URL do arquivo.

[03:30] Aqui eu passo o diretório, aqui eu passo o outro parâmetro e aqui, só para vermos como é que vai ficar, eu vou passar como true e eu vou colocar um print(url) dessa URL do arquivo.

[03:48] Eu vou no "ReciboViewController", e vou chamar no viewDidLoad esse método, para entendermos para que serve aquele parâmetro. Então Perfil().carregarImagem().

[04:06] Vou deixar aqui momentâneo, só para fazermos esse teste. Vou voltar no "Perfil", ele está reclamando, que precisamos retornar o UIImage. Por enquanto eu vou retornar aqui return nil, só para conseguirmos biuldar e vou colocar um breakpoint na linha 46.

[04:24] Eu vou rodar o projeto, vou limpar o console e vou passar para a linha debaixo. Olha que interessante.

[04:36] Ele nos traz aqui um diretório, que é exatamente onde a nossa imagem está salva, tanto é que se eu pegar link, vou dar um "Command + C", vou abrir o Finder, eu vou nessa opção "Go > Go to Folder...". Aqui eu coloco o endereço da pasta, "Go to Folder". Vou colar aqui e ele me traz a imagem que nós salvamos.

[05:07] É exatamente isso que nós estávamos fazendo, montando essa URL, esse caminho, onde nós iríamos salvar a imagem. O que eu queria mostrar aqui para você é esse parâmetro onde nós deixamos true, que antes dessa pasta "Document", ele nos traz todo esse caminho.

[05:28] Se eu deixar false, olha como fica, ele vai abreviar um pouco com o til, e vamos ver então como fica a URL do arquivo. Fica dessa maneira, [“~/Documents”].

[05:44] Então esse parâmetro serve para isso. Eu vou manter como true, vou parar a execução do nosso programa, vou tirar o breakpoint. Então já vimos que a URL está correta, nós conseguimos acessar a nossa foto através do nosso Finder. Agora, de fato, como já temos a URL, já podemos acessar a imagem, é isso o que vamos fazer.

[06:12] Eu vou fazer uma verificação, porque aqui ele vai retornar - se eu pegar essa URL do arquivo, ele vai me retornar, na verdade, várias coisas nessa URL, porque é um array de strings. Eu vou pegar então a primeira posição. Eu vou fazer o seguinte, vou criar uma constante if let caminho =, vou pegar = urlDoArquivo.first {}. E eu tenho acesso ao caminho. O que eu vou fazer agora?

[06:44] Agora eu vou montar aqui a URL da imagem como URL mesmo, let urlDaImagem = URL(), então eu vou pegar esse = URL(fileURLWithPath: caminho), vou passar o caminho. Aqui, na verdade, precisamos do nome da foto, então, além do caminho, precisamos do nome da foto, que teremos que concatenar, assim como fizemos aqui em cima.

[07:17] Nós temos aqui o nomeDaFoto e nós concatenamos com o diretório. É basicamente isso que nós vamos fazer aqui, nós vamos utilizar o caminho e precisamos concatenar com o nome da foto. Como vamos utilizar o nome nos dois lugares, vou dar um "Command + X" e vou arrastar para cima como uma constante da classe.

[07:40] Então eu consigo acessar tanto nesse método quanto no método carregarImagem. O que eu vou fazer então? Eu vou dar um .appendingPathComponent(), onde eu vou passar aqui o (nomeDaFoto). Se eu chamar ela aqui embaixo, eu já tenho acesso então à URL da imagem.

[08:01] Com isso já conseguimos fazer a transformação para UI image. Eu vou criar aqui a let imagem =, vou chamar a = UIImage(). Ele tem um método bem bacana, que é esse (ContentsOfFile:), ele vai verificar o conteúdo do arquivo e vai tentar fazer o cast para UI image. Então, eu passo a : urlDaImagem).

[08:25] Agora, o que vamos fazer? Vamos retornar a imagem aqui, return image. Ele está reclamando pelo tipo, olha só, o ContentsOfFile, ele precisa dele como string e nós estamos passando a URL da imagem como URL, então é só dar um urlDaImagem.path para converter para string.

[08:53] Então já temos aqui um método onde nós vamos carregar a imagem de volta. Agora vamos voltar no "ReciboViewController", vou tirar aquela chamada daqui e eu vou criar um novo método, que será o func getFotoDePerfil(). O que eu vou fazer aqui? Eu vou fazer uma verificação, porque se eu chamar let perfil = Perfil()., que é a classe que nós estamos utilizando para salvar.

[09:32] Se eu chamar esse método .carregarImagem, ele retorna um UI image opcional. Para não trabalhar com o opcional, eu vou fazer uma validação, if let imagemDePerfil = Perfil()., instancio a classe, chamo o método .carregarImagem(). Aqui eu vou pegar o meu outlet, fotoPerfilImageView.image = imagemDePerfil.

[10:02] Então o que vamos fazer com esse método? Nós precisamos chamar ele de algum lugar. Nós temos aqui o método viewDidAppear, e eu vou chamar ele aqui embaixo, getFotoDePerfil().

[10:16] Então já estamos utilizando a classe, já estamos utilizando o método, estamos setando a imagem no nosso outlet, no nosso UI image. Agora vamos rodar o simulador para fazermos esse teste e vermos se realmente está funcionando. Olha que bacana.

[10:37] Já tenho a imagem carregada, e o mais legal é que se eu fechar o aplicativo e abrir novamente, temos acesso à foto. É dessa forma que nós recuperamos um arquivo utilizando o File Manager.

@@06
Entendendo o uso do File Manager

Qual a principal diferença entre salvar uma informação usando Core Data e File Manager?

O File Manager é utilizado para salvar arquivos em determinados diretórios que podem ser configurados de acordo com a necessidade. Já o Core Data é utilizado para persistência de objetos, na qual podemos criar consultas robustas através dessa API.
 
Alternativa correta! Com o File Manager, é possível criar pastas em que podemos salvar diferentes tipos de arquivos, inclusive imagens.
Alternativa correta
O File Manager é utilizado para salvar apenas imagens em diretórios (pastas) que podem ser configuradas de acordo com a necessidade. Já o Core Data é utilizado para persistência de objetos, na qual podemos criar consultas robustas através dessa API.
 
Alternativa correta
O File Manager é utilizado para persistência de objetos, em que podemos criar diversas consultas SQL. Já o Core Data é utilizado para salvar arquivos em diretórios.

@@07
Para saber mais: Salvando arquivos

Neste primeiro capítulo, continuamos as implementações do projeto Alura Ponto. Uma das funcionalidades que implementamos no curso anterior foi o uso da biblioteca de imagens para configurar a imagem de perfil do funcionário.
O problema é que sempre que encerrávamos o aplicativo e o abríamos novamente, a imagem era perdida.

Uma das formas de solucionar esse problema foi o uso do File Manager (gerenciador de arquivos do iOS).

Através dele, podemos armazenar arquivos em diretórios como se fossem pastas de um sistema operacional.

@@08
Faça como eu fiz: File Manager

Nesse primeiro capítulo, aprendemos outra maneira de trabalhar com persistência no iOS. Dessa vez, salvando local arquivos, onde primeiro criamos um diretório e depois utilizamos esse caminho para salvá-lo.

Todos os frameworks que utilizaremos estão listados na página de desenvolvimento da Apple.

https://developer.apple.com/develop/

@@09
O que aprendemos?

Nesta aula, aprendemos que, através do File Manager, podemos fazer com que persistam diversos tipos de arquivos. No nosso caso, aprendemos a salvar a imagem de perfil do usuário da tela de consulta de registros de pontos.

#### 25/08/2023

@02-Autenticação local

@@01
Projeto da aula anterior

Se você deseja começar o curso a partir desta aula, pode fazer o download do projeto desenvolvido até o momento.

https://github.com/alura-cursos/2316-alura-ponto-parte2/archive/2594825faccfb0ee10cf06469deee38f3e91df65.zip

@@02
Autenticação local

[00:00] O próximo recurso que nós vamos começar a estudar é o de autenticação local. É muito comum hoje em dia, nós vemos em apps de banco principalmente, ou algum aplicativo que peça alguma informação sensível, você precisar autenticar a sua biometria, ou o seu face id com o iPhone, para você conseguir utilizar algum recurso.
[00:27] No caso de aplicativos de banco, para você acessar a sua conta, enfim, esse é um recurso que está cada vez mais sendo utilizado, então é muito importante sabermos utilizar essa biblioteca também. No nosso caso, nós temos o nosso app de ponto, eu vou buildar ele de novo aqui. A ideia do aplicativo é registrar alguns pontos de horário de trabalho dos funcionários.

[01:00] Nós temos aqui, por exemplo, uma lista com alguns recibos de ponto. Nós vamos utilizar esse recibo para implementarmos esse recurso de autenticação. A ideia é não deixar qualquer pessoa que pegue o seu celular conseguir deletar um recibo, então vamos pedir autorização do usuário quando clicarmos em deletar um recibo.

[01:24] Hoje nós podemos vir na lista, clicar e deletar um recibo. A ideia é bloquearmos esse acesso de qualquer pessoa conseguir realizar essa ação. Vamos lá, para começar, vamos no "ReciboViewController", nós temos aqui um método onde nós deletamos um recibo, que é esse método delegate aqui.

[01:49] E nós temos essas duas linhas, que já funcionam muito bem e conseguimos deletar o recibo. A ideia é colocarmos aqui uma validação de autenticação do usuário, para isso vamos utilizar o framework chamado local authenticator, é ele que nos dará acesso a essa funcionalidade do iPhone ou iPad.

[02:15] Vamos lá, para começar, eu vou criar um gerenciador de autenticação, let authenticatorContext =, que é do tipo = LAContext. Nós não temos acesso a esse LAContext porque precisamos importar esse framework. Nas versões mais novas do Xcode ele já é importado automaticamente, import LocalAuthentication.

[02:53] Vamos voltar ao código e utilizar esse = LAContext(), LA de local authentication. Com isso, o que vamos fazer? Assim como a maioria dos recursos que nós estamos utilizando, nós precisamos verificar se existe essa disponibilidade de uso desse recurso. Se você for pegar, por exemplo, iPhones mais antigos, bem mais antigos, não tinha esse recurso de autenticação.

[03:28] Hoje em dia já é muito comum todos os iPhones que nós vemos já virem com esse recurso, mas sempre é interessante realizarmos essa validação para ver se existe esse recurso disponível. Como faremos isso? Eu vou fazer aqui um if desse authentication context, e temos esse método, if authenticationContext.canEvaluatePolicy().

[03:53] Ele pede que passemos dois parâmetros, um erro e um tipo de autenticação que nós queremos. Podemos, por exemplo, pedir a autenticação somente com a biometria ou biometria e o face id. É exatamente esta que vamos pedir. Como é um enum, se eu apertar o ponto ele já me traz duas opções, eu quero a autenticação com biometria, (.deviceOwnerAuthenticationWithBiometrics, error:.

[04:24] Aqui nós podemos passar um erro qualquer. Esse NSErrorPointer, na verdade, é um erro, mas precisamos passar um parâmetro do tipo in out, que é um parâmetro que conseguimos mudar alguma coisa quando recebemos por parâmetro. Por exemplo, aqui por default, todos os métodos que pedimos algum parâmetro, ele vem como constante, então se tentarmos mudar o valor desse parâmetro dentro do método, não conseguimos.

[05:04] Se mudamos para in out, inout, dessa forma aqui, nós conseguimos alterar as configurações ou as propriedades do que estamos recebendo por parâmetro e utilizar isso. Eu falei tudo isso porque precisamos criar um erro, que é do tipo let error: NSError?, opcional. Aqui tem que ser um var error: NSError?, porque vamos passar ele por parâmetro.

[05:37] Só que se passarmos ele assim, error comum, ele vai dar erro, então "Command + V", ele não vai deixar passar dessa maneira, nós precisamos colocar &error. Passando o parâmetro dessa forma, o método consegue alterar alguma propriedade dessa variável na implementação do método, por isso passamos com o "&".

[06:04] Feita a validação, podemos utilizar, de fato, essa biblioteca. Ela é bem simples de utilizar, vamos chamar o nosso authenticationContext., ele tem esse método .evaluatePolicy(). Mais uma vez, precisamos passar que queremos utilizar a biometria e o face id. Podemos colocar uma mensagem quando exibirmos aquela tela de bloqueio, para o usuário entender o porquê ele está autenticando.

[06:40] Por exemplo, "É necessário autenticação para apagar um recibo". Essa é a mensagem que vamos passar. O próximo parâmetro que nós temos aqui, na verdade é uma closure, como um bloco de sucesso ou erro. Só para ficar mais bonito aqui, eu vou apagar e eu vou fazer o seguinte, eu vou pegar o parâmetro de sucesso, o parâmetro de erro, e nós vamos então utilizar uma closure.

[07:35] Dentro, se ele entrar nesse bloco, significa que já temos uma resposta, pode ser sucesso ou erro. Vamos verificar, se for sucesso, então if sucesso {}, vamos de fato apagar o recibo. Vou passar a implementação do deletar o recibo aqui para cima.

[08:00] Aqui ele está reclamando porque nós estamos dentro de uma closure, então temos que colocar o self?. E aqui estamos utilizando o contexto, que é essa variável contexto. Mas o problema é que estamos utilizando aqui o self como opcional, pode ser que exista contexto ou não. Nós teremos que fazer mais uma verificação aqui, if let contexto = self?.contexto {}, se existir o contexto, nós vamos apagar o recibo dessa maneira, recibo.deletar(contexto).

[08:45] A única coisa que temos que tomar cuidado aqui é porque como ele está voltando da closure, nós precisamos chamar esse método de deletar na tred principal. Eu vou chamar esse método DispatchQueue.main.async e eu vou passar toda essa implementação para dentro dele.

[09:13] Então, essa é a implementação que precisamos para apagar um recibo. O que eu vou fazer? Eu vou gerar um build e nós tentaremos utilizar esse recurso, vamos ver se vai funcionar ou se vai faltar alguma coisa. Vamos no nosso simular, vou em "Recibos", vou clicar em apagar e não aconteceu nada.

[09:42] Vamos ver o que está acontecendo no código. Vou colocar o breakpoint, ele parou aqui e ele está saindo fora. Essa parte do código serve para verificarmos se tem o recurso disponível.

[10:00] Como estamos utilizando o simulador, nós vamos utilizar um recurso do próprio simulador para realizar esse teste, nós conseguimos fazer isso no simulador. Vou em "Features", tem o "Face ID", primeiro eu vou clicar nessa opção "Enrolled". No simulador, vou clicar mais uma vez em apagar o recibo e temos um crash.

[10:24] Isso é muito importante para entendermos qual é o erro. Se viermos no console, ele indica que precisamos utilizar o nosso "info.plist" para pedir a permissão do usuário para utilizar esse recurso. Parece que já passamos por isso antes, quando fomos utilizar a câmera, quando fomos utilizar a biblioteca de fotos.

[10:47] Vários recursos que temos disponíveis no iPhone nós precisamos da autorização do usuário, e esse é um deles. Então, antes de utilizarmos, o que vamos fazer? Pausei a execução, vou ao arquivo "Info.plist", e vamos adicionar essa permissão, vamos pedir a permissão do usuário.

[11:12] Vou adicionar uma nova entrada. O que vamos digitar aqui? Eu vou começar digitando "privacy" e ele vai me trazer uma lista de coisas: bluetooth, calendário, câmera, tem várias coisas. Nós precisamos utilizar essa, a "Privacy - Face ID Usage Description", é essa a entrada que nós precisamos.

[11:39] Vou dar um clique nela. O que vamos fazer aqui? Vamos colocar também uma mensagem: "É necessário utilizar a autenticação para ter acesso às configurações". Vou rodar mais uma vez o nosso simulador, vou voltar no nosso código. Cliquei em "Recibos" no simulador, cliquei no "X".

[12:22] Olha que interessante, ele pergunta se você autoriza o Alura Ponto a utilizar o face id, e aparece a mensagem que nós colocamos no "Info.plist": "É necessário utilizar a autenticação para ter acesso às configurações". Vou dar um "Ok". Nós já temos a autorização do usuário. Agora ele entrou nessa tela, simulando o uso do face id.

[12:47] Como eu autorizo isso? Vou em "Features > Face ID" e vou colocar esse "Matching Face". Ele autoriza e deleta. Vamos ver se deletou mesmo? Vou rodar o projeto de novo, vou em "Recibos" e nós só temos três.

[13:08] É importante tratarmos também casos de erro. Se você for utilizar isso no seu aplicativo, você pode simular, caso não tenha autenticado, ou seja, caso a pessoa não valide a autenticação, você pode vir em "Features > Face ID" e clicar nesse "Non-matching Face", ou seja, não é o usuário que está utilizando o celular.

[13:34] Ou seja, não é para autenticar. Nesse caso eu poderia exibir um alert controller, poderia tratar, mas é uma observação importante que temos que pontuar. Então é relativamente tranquilo nós utilizarmos essa lib do local authenticator, porém ainda podemos refatorar algumas coisas.

[13:58] Como, por exemplo, nós estamos extraindo os comportamentos de bibliotecas para algumas classes, para não deixar o view controller massivo, cheio de coisas que não deveria, então esse é um caso que podemos criar uma classe específica para autenticação. Vamos, a seguir, separar essas responsabilidades, deixar tudo isso separado em uma classe de autenticação.

@@03
Refatorando classe autenticação

[00:00] Vamos refatorar então essa implementação da autenticação local que nós criamos aqui. A ideia é extrairmos tudo isso para uma classe e deixar o view controller sabendo da menor quantidade de coisas possível, então ele só vai chamar uma classe que executa essa ação de autenticar, mas ele não sabe qual o framework, não tem implementação de nada. Vamos tentar limpar um pouco essa implementação.
[00:29] Aqui vamos criar uma nova classe, ou struct, dentro da pasta "Model". Botão direito, novo arquivo, ele nos traz as opções de classe, vou escolher "Swift File". O nome do arquivo será autenticação, sem acento, local, "AutenticacaoLocal". Vou dar um "Create" e vamos criar uma classe para nos ajudar com isso.

[01:05] Vou apertar a tecla "Command + T", quando eu aperto "Command + T" eu consigo trabalhar com duas janelas, basicamente. Em uma eu vou deixar a classe que nós criamos e na outra eu vou deixar o "ReciboViewController". Para começar, eu vou pegar essa constante e essa variável error e vou passar para a nova classe. "Command + X", vou colocar elas na outra aba.

[01:42] Temos private authenticatorContext = LAContext(), private var error: NSError?, que nós não queremos que ninguém de fora enxergue essas variáveis. Aqui ele está pedindo para importar o local authentication context, então voltamos no "ReciboViewController", vamos tirar esse import do view controller, "Command + X", e vamos passar para a classe que nós acabamos de criar, "Command + V".

[02:11] Agora, o que vamos fazer? Eu vou criar um novo método dentro da classe AutenticacaoLocal, vai se chamar func autorizaUsuario(). Dentro desse método, precisaremos daquela verificação, do if, se podemos utilizar esse recurso. Eu vou pegar esse if do view controller, vou dar um "Command + C", vou passar para o novo método.

[02:47] Dentro dele vamos de fato chamar a autenticação. Eu vou pegar todo esse código do view controller, "Command + C", "Command + V", só está faltando uma chave. O que eu vou fazer aqui?

[03:10] Eu preciso, de alguma forma, saber no view controller se ocorreu um sucesso ou um erro para de fato deletarmos o recibo, porque essa parte nós vamos manter no view controller, todo o resto vamos passar para a nova classe. Primeiro, o que eu vou fazer aqui? Eu vou dar um "Command + X", vou apagar toda essa parte do código e vou deixar o nosso método como era antes.

[03:45] Até esse flat agora eu não preciso mais, porque o self era opcional, agora não é. Então o nosso método antigamente era assim. Vou tirar esse ponto de interrogação do self. O que precisamos fazer?

[04:00] A ideia é utilizarmos a classe que nós criamos, então seria mais ou menos assim: AutenticacaoLocal.autorizaUsuario(). Só que precisamos saber se ocorreu um erro ou se deu sucesso, para apagar o recibo ou não. Nós precisamos do retorno dessa função. Nós podemos utilizar um recurso bem interessante, que se chama closure, que é, na verdade, implementar uma função dentro de outra função.

[04:31] Nós vamos fazer isso para nos ajudar a ter acesso à resposta da autenticação. Aqui, na assinatura do método autorizaUsuario, o que vamos fazer? Vamos criar um bloco de func autorizaUsuario(completion: ), quer será o seguinte, nós precisamos colocar essa palavra reservada : @escaping(), e vamos passar a (autenticacao: Bool) ->, que é do tipo booleano.

[05:00] E aqui retornamos -> Void), ou seja, sem retorno. Quando fazemos isso, olha que interessante, quando chamamos agora esse método autorizaUsuario, ele mudou, olha como ele está.

[05:16] E quando eu aperto o "Enter", eu tenho acesso à variável que nós criamos na nova classe, que é essa autenticacao. Então eu posso dar um nome para essa variável, eu vou dar o nome, por exemplo, de autenticado e aqui eu consigo fazer uma verificação, if, se for autenticado, eu pego tudo isso, que é o método onde deletamos o recibo, e de fato deleto.

[05:50] Mas, para isso funcionar, nós precisamos chamar - aqui ele está reclamando porque estamos dentro de uma closure, então precisamos do self, recibo.deletar(self.contexto).

[06:03] Só que agora precisamos chamar esse completion aqui embaixo, na "AutenticacaoLocal". Vou passar o completion() e vou passar o (sucesso). Como não estamos mais utilizando nenhuma referência, podemos até tirar, para ele parar de dar warning, e temos então esses dois parâmetros.

[06:32] Como faremos então para testar? Vamos rodar o nosso projeto, ele vai verificar se estamos de fato apagando um recibo utilizando a autenticação. Vamos lá, vou rodar o meu simulador, vou fechar essa parte de baixo, para ganharmos espaço. Olha que legal, eu vou vir no "Recibos", vou apertar o "X" e não estamos ainda conseguindo apagar. Vamos ver o que está acontecendo.

[07:10] Vou colocar um breakpoint, vou clicar no "X" no simulador. Ele caiu dentro do breakpoint, vamos entrar no método. Aqui o que precisamos, na verdade, é ir em hardware e utilizar esse recurso do simulador. Se você estiver utilizando seu iPhone físico para testar, você não terá nenhum problema. Como estamos utilizando o simulador, precisamos ir em "Features > Face ID > Enrolled".

[07:47] Vou marcar a opção, vou entrar no método. Vou de novo em "Feature > Face ID", vou autorizar o uso. Vou clicar no "X" no simulador, ele vai abrir a tela do face id, como se estivéssemos olhando para o iPhone, por isso apareceu aqui esse "Face ID".

[08:17] Temos duas opções: ou autorizamos, que é o caso que vamos fazer agora, esse "Features > Face ID > Matching Face", significa que é a autenticação do usuário mesmo, ou não autorizamos e tratamos o erro, caso queiramos fazer isso. Vou autorizar, ele caiu aqui no código e vai deletar o recibo perfeitamente. Tirei o breakpoint, vou clicar no ícone de play, em continuar a execução do programa, e ele apagou.

[08:49] Mais uma vez, eu posso clicar no "X" no simulador, dessa vez eu vou em "Features > Face ID" e vou clicar em "Non-matching Face", ou seja, não vou autorizar, ou é outra pessoa que pode ter pego o seu iPhone, não sei. Ele dá um erro, falando que a face não foi reconhecida.

[09:13] Nós poderíamos tratar um erro aqui. O mais importante é que agora nós extraímos a responsabilidade de autenticação local para uma classe específica. Essa classe, ela tem a implementação do framework, ela tem a implementação e a utilização desse framework.

[09:37] Dessa forma conseguimos deixar o nosso view controller um pouco mais limpo. Então esse é o recurso de autenticação local, ele é muito utilizado para essas coisas que já comentamos, como apps de banco ou quando você precisa fazer alguma operação mais sensível no seu aplicativo, sempre é interessante utilizarmos esse tipo de recurso.

@@04
Autenticação do iOS

Um recurso muito interessante para melhorar a segurança do app é a autenticação local.
Qual classe utilizamos para utilizar esse recurso?


Alternativa correta
OAuth
 
Alternativa correta
LAContext
 
Alternativa correta! Correto. A classe CLContext permite que o app solicite que o usuário se autentique usando a biometria/face id ou a senha numérica cadastrada no iOS.
Alternativa correta
LContext
 
Alternativa correta
AutenticationContext
 
Parabéns, você acertou!

@@05
Faça como eu fiz: Uso da autenticação no app

O uso da classe LAContext nos possibilita utilizar o recurso de autenticação do iOS (biométrico, senha ou face id).
Um bom exemplo de aplicação, em nosso projeto, é no momento de deletar uma marcação de ponto, no qual o ideal é que somente o proprietário do dispositivo possa fazer esse tipo de operação.

Como podemos implementar isso em nosso projeto?

Para utilizar o recurso de autenticação, podemos criar uma classe como essa:
import Foundation
import LocalAuthentication

class AutenticacaoLocal {

    private let authenticatorContext = LAContext()
    private var error: NSError?

    func autorizaUsuario(completion: @escaping(_ autenticao: Bool) -> Void) {
        if authenticatorContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticatorContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "É necessário autenticação para apagar um recibo") { sucesso, error in

                completion(sucesso)
            }
        }
    }
}

@@06
O que aprendemos?

Nessa aula, aprendemos como utilizar o recurso de autenticação local para proteger determinadas operações em nosso aplicativo. É importante ressaltar que muitos aplicativos bancários e que cuidam de operações sensíveis utilizam esse recurso.

#### 26/08/2023

@03-Utilizando a localização do usuário

@@01
Projeto da aula anterior

Se você deseja começar o curso a partir desta aula, pode fazer o download do projeto desenvolvido até o momento.

https://github.com/alura-cursos/2316-alura-ponto-parte2/archive/7c800b3d1e7ae0fc3a9998698aaf11351db4ff92.zip

@@02
Trabalhando com Core Location

[00:00] A partir de agora vamos começar a falar um pouco sobre localização, então nós vamos utilizar um framework que se chama core location. A ideia é, a partir de agora, nós sabermos onde foi batido o ponto do funcionário. A empresa solicitou essa nova regra de negócio, que ela deseja saber qual a localização do funcionário no momento em que ele bate o ponto, e vamos implementar essa funcionalidade.
[00:29] Quando falamos em localização, traduzindo tudo o que a lib faz, trabalhamos com latitude e longitude, então precisamos saber a localização atual do usuário para salvarmos a latitude e a longitude. Isso é muito utilizado em aplicativos de paquera, onde você passa em determinada região e você consegue saber quem está por perto, enfim, é mais ou menos por esse caminho.

[00:57] Então sabendo a localização do usuário, você consegue mostrar no mapa onde é que foi registrado, no nosso caso, o ponto. Então vamos começar a entender como funciona a utilização da localização do usuário. Nós vamos voltar no "HomeViewController", nós vamos criar uma nova variável, eu vou chamar de var gerenciadorDeLocalizacao =. Ela é do tipo = CL, de core location, = CLLocationManager.

[01:38] Eu vou utilizar aqui uma variável, um lazy var, então, na verdade, eu vou deixar dessa maneira, lazy var gerenciadorDeLocalizacao. Lazy var, ele é instanciado somente no momento em que a variável for utilizada, então ele ajuda no gerenciamento de memória. Com isso, vamos criar então um novo método, dentro do nosso view controller por enquanto, e vamos chamar esse método de func requisicaoDaLocalizacaoDoUsuario().

[02:21] Eu não sou muito bom com métodos em português, mas vamos deixar assim, func requisicaoDaLocalizacaoDoUsuario(). O que precisamos fazer? Há alguns controles de estado quando trabalhamos com localização, então podemos pedir a localização do usuário somente quando ele estiver com o aplicativo em primeiro plano, ou seja, ele estiver usando o aplicativo.

[02:49] Podemos também pedir a solicitação para sempre conseguir trackear a localização do usuário, independente se ele está com o app aberto ou em segundo plano, por exemplo, no caso de GPS, você pode estar utilizando o GPS do celular, quando você vai para outro aplicativo, ele continua mapeando a sua localização, esse é um exemplo de sempre pedir a localização do usuário.

[03:16] O usuário pode negar ou ainda ele não pode ter visto nenhuma dessas opções, pode ser a primeira vez dele, então não tem nada determinado. Baseado nisso, vamos trabalhar com esses tipos de requisições de localização que nós temos. Primeiro vamos utilizar alguns métodos do nosso gerenciador de localização, principalmente para trackear o momento em que muda a sua localização, enfim.

[03:48] Tem alguns métodos de delegate que vamos implementar, então, por isso eu estou setando o gerenciadorDeLocalizacao.delegate = self aqui. Nós vamos implementar este protocolo aqui embaixo, extension HomeViewController: CLLocationManagerDelegate {}. Implementamos, só para ele parar de reclamar, e agora vamos começar então as implementações.

[04:17] Primeiro, como sempre, vamos fazer a verificação se o recurso está disponível no device que estiver em uso. Como eu faço isso? if CL, de core location, if CLLocationManager., eu dou esse .locationServicesEnabled(), vamos verificar se o recurso está disponível. Se estiver, vamos utilizar.

[04:41] switch gerenciadorDeLocalizacao.authorizedStatus, vamos saber qual é o status. Pode ser que o usuário já tenha sempre autorizado, ou ele pode ter autorizado somente quando o aplicativo está em uso, nesses dois casos, case .authorizedAlways, .authorizedWhenInUse: break, por enquanto eu não vou fazer nada. Quais outros casos nós temos também?

[05:03] Nós temos o case .denied, ou seja, ele não autorizou, então poderíamos aqui, por exemplo, //Mostrar um alert explicando e pedindo novamente a autorização. Esse seria um caso. Quais outros casos que temos aqui que são interessantes sabermos? No caso de não estar determinado ainda, ou seja, nós nunca pedimos a localização para o usuário.

[05:39] Então para nós agora isso é muito importante, porque podemos pegar o gerenciador de localização e pedir a autorização, gerenciadorDeLocalizacao.requestWhenInUseAuthorization(). Nós vamos pedir autorização quando o aplicativo estiver em uso. Depende muito da regra de negócio que você está utilizando no seu app.

[05:56] Se sempre você precisar da localização do usuário então você precisa mudar aqui para gerenciadorDeLocalizacao.requestAlwaysAuthorization(). Então depende muito da regra de negócio do seu app. Em default: não vou pôr nada. Já temos aqui o nosso primeiro método, que serve para verificar qual é o status da autorização do usuário.

[06:26] Então se ele já autorizou, sempre ou quando o app está em uso, se ele não autorizou, se ele negou, ou se ele ainda não escolheu nenhuma opção, se é a primeira vez que o app é aberto, por exemplo. Nós vamos chamar esse método no viewDidLoad(), vou colocar aqui requisicaoDaLocalizacaoDoUsuario().

[06:48] Agora vamos trabalhar aqui um pouco, nesses métodos de delegate. Existem dois métodos que são muito importantes, o primeiro é esse did change authorization. Assim que o usuário autorizar ou negar, ou fazer alguma coisa em relação à autorização, ele cai neste método e nós conseguimos fazer alguma coisa.

[07:12] Por exemplo, eu abro o aplicativo, o usuário autorizou, então eu já quero começar a trackear a localização dele. É aqui que nós mexemos. O que vamos fazer aqui? switch para verificar os casos que nós temos, ele já me traz, pela assinatura de método, esse manager, só que eu preciso saber da autorização do status, switch manager.authorizationStatus.

[07:41] Se ele autorizou sempre ou quando o app está em uso, é o que eu preciso, vou pegar o meu gerenciadorDeLocalizacao. e vou começar a atualizar a sua localização, .startUpdateLocation(). default, não vou fazer nada.

[08:01] O segundo método é de fato quando o usuário se mexe, ou seja, quando ele muda de localização, já queremos saber onde ele está para registrar o ponto, então precisamos saber e conseguimos isso através desse método, que é did update location. Basicamente ele traz esse parâmetro que é muito importante, que é esse location:, onde conseguimos ter acesso à latitude e à longitude do usuário através dele, que é o que de fato precisamos.

[08:33] Eu vou fazer um if let, por exemplo, if let localizacao = locations.first {}. Aqui, olha que bacana, eu consigo ver a print(localizacao.coordinate.latitute) e a mesma coisa com a longitude, print(localizacao.coordinate.longitude). No fim das contas é desses dois dados que nós precisamos.

[09:08] Como já cansamos de ver, nós precisamos fazer um outro passo, que também é muito importante, que é pedir a autorização do usuário, principalmente com localização, que é algo muito sensível, o usuário precisa saber que o nosso aplicativo está monitorando a sua localização. Como fazemos isso?

[09:30] Através do "Info.plist". Nós vamos adicionar uma nova entrada no nosso "Info.plist", vou digitar "Privacy" e vamos procurar por location. Tem vários aqui, location always usage description, o que precisamos é essa opção aqui, "Privacy - Location When In Use Usage Description". Vamos utilizar essa entrada no nosso "Info.plist".

[10:08] E podemos colocar a nossa mensagem, explicando para o usuário porque nós precisamos utilizar esse recurso do device dele: "Precisamos de sua localização para registrar o ponto eletrônico". Feito tudo isso vamos então testar. Vou colocar um breakpoint na linha 129, vou rodar o aplicativo. Olha que legal.

[10:50] Já temos aqui essa mensagem pedindo a autorização do usuário, eu vou colocar aqui "Allow While Using App", vou permitir enquanto o app estiver rodando. É importante nós utilizarmos esse recurso do simulador, que é esse ícone de seta, de simular a localização.

[11:17] Quando você estiver rodando no seu device não vai precisar, mas como estamos rodando no simulador, podemos simular alguma dessas localizações aqui.

[11:28] Eu coloquei "Rio de Janeiro, Brazil" e ele caiu nesse método didUpdateLocation. Então aqui temos acesso, de fato, à latitude e à longitude do usuário.

[11:42] Vou tirar o breakpoint, vou continuar a execução do programa. Nós já conseguimos dar os primeiros passos na utilização do core location, já temos aqui a latitude e a longitude. Agora precisamos salvar essa latitude e essa longitude, então teremos que adicionar mais dois atributos na nossa classe e também vamos ter que mexer no schema do core data, mas veremos isso a seguir.

@@03
Salvando latitude e longitude

[00:00] Agora que nós já temos acesso à latitude e à longitude, nós precisamos modificar algumas coisas no nosso projeto como, por exemplo, a classe "Recibo", porque a partir de agora começaremos a salvar a localização do usuário assim que batemos o ponto. Então precisamos adicionar dois atributos aqui, a latitude e a longitude, e também nós precisamos mexer no schema do nosso data model no core data.
[00:30] Vamos começar essas alterações. Eu vou voltar para a "HomeViewController". Primeiro vamos criar duas variáveis, que vão guardar os valores da latitude e da longitude, então será o seguinte, aqui em cima eu vou criar duas variáveis, private var latitude:.

[00:58] A latitude é desse tipo : CLLocationDegrees?. Mas, no fundo, se seguramos a tecla "Command", clicarmos na palavra e clicarmos em "Jump to Definition", no fim das contas ele é um typealias, ele é um apelido para dizer que é um double.

[01:21] Só para entendermos, é um double mesmo. Vamos criar então uma variável também para a longitude, que é do tipo private var longitude: CLLocationDegrees?. Com essas duas variáveis, já podemos utilizar elas aqui embaixo. Vou fazer o seguinte: latitude = localizacao.coordinate.latitude. E longitude = localizacao.coordinate.longitude. Já estamos armazenando a latitude e a longitude.

[01:58] Quando salvamos - quando escolhemos a foto, na verdade, que é esse método de delegate, o didSelectFoto, nós criamos o objeto recibo e depois salvamos ele. Então vamos adicionar mais dois atributos nesse método. Vamos começar mexendo no schema do core data. Nós já temos aqui o que nós estamos persistindo nessa entidade "Recibo".

[02:30] Nós temos a data, a foto, o ID, o status e vamos adicionar a latitude, como nós havíamos falado, ele é, na verdade, um type alias para double, então podemos deixar como double. E também adicionar a longitude, latitude e longitude, também como double.

[02:59] Com isso já podemos alterar o nosso modelo, o nosso recibo. A partir de agora, além do status, da data e da foto, nós teremos a latitude:, podemos enviar como : Double mesmo, e teremos também a longitude: Double.

[03:30] Vamos criar aqui mais dois atributos, vamos seguir esse mesmo padrão, como eles serão mapeados para salvar no core data, então precisamos seguir esse padrão. @NSManaged var latitude: Double, @NSManaged var longitude: Double. E agora utilizamos ele aqui, self.latitude = latitude e self.longitude = longitude.

[04:15] Vou dar um "Command + B" para buildarmos o projeto. Como nós mudamos a assinatura do método, então agora teremos que alterar também no "HomeViewController". Agora temos a latitude, nós já temos uma variável aqui, que nós declaramos lá em cima para latitude e também para longitude, então é só passar elas aqui embaixo, longitude: longitude.

[04:45] Então, "Command + B", que é opcional. E no nosso "Recibo", nós pedimos que passe a latitude e a longitude sem ser opcional, mas podemos fazer uma verificação aqui, se não existir valor, setamos como 0 e a mesma coisa na latitude.

[05:13] O que vamos fazer agora? Eu vou colocar um breakpoint na linha 115 - na verdade, eu vou rodar o projeto, vamos ver se a latitude e a longitude estão sendo preenchidas. Vamos colocar um breakpoint na linha 133. Agora eu vou utilizar uma localização, vamos ver o valor dessas variáveis, po latitude, po longitude.

[05:47] Agora, na hora que salvarmos um ponto, ele já vai passar então as informações corretas. Uma coisa interessante, que nós veremos a seguir, é como movemos essa localização, toda essa parte de localização para uma classe separada.

[06:09] Estamos batendo bastante nessa tecla de não deixar o nosso view controller, o que a comunidade chama de massive view controller, o view controller massivo, com muitas informações que não dizem respeito a ele e sim a outras implementações. Por que estamos nos preocupando tanto com isso?

[06:28] Principalmente pela qualidade do código, então é muito importante conseguirmos dar uma manutenção fácil, se eu preciso mexer em localização, eu já sei que tem uma classe responsável para isso, eu preciso mexer na autenticação, eu já sei que tem uma classe responsável por isso.

[06:44] Imagine se deixássemos tudo no view controller, ia virar uma salada de fruta e seria muito difícil entendermos e, de fato, conseguirmos fazer alguma refatoração. Então, a seguir, veremos como fazemos para refatorar essa parte da localização.

@@04
Testando a localização

[00:00] Agora vamos refatorar toda a parte da localização para uma nova classe, que nós vamos criar agora. Aqui, na pasta "Model", nós já estamos centralizando várias funcionalidades, vamos criar uma nova classe "Swift File", chamada "Localizacao". "Create". Vamos começar criando um método para pedir a permissão para o usuário, semelhante ao que já fizemos no view controller.
[00:37] Vou chamar de func permissao(). Nós vamos receber, por parâmetro, o ( gerenciadorDeLocalizacao:, que é do tipo : CLLocationManager). Aqui, na verdade, precisamos importar o import CoreLocation. : CLLocationManager).

[01:12] Além disso, vamos precisar de algumas variáveis para armazenar, por exemplo, a latitude e a longitude, então já vou criar elas aqui, private var latitude: CLLocationDegrees?, porque nós vimos que, no fundo, isso é um double, é apenas um type alias, private var longitude: CLLocationDegrees?.

[01:42] E também nós vamos implementar o protocolo onde vamos enxergar, na verdade, todos esses métodos do view controller de localização, esse locationManagerDidChangeAuthorization e esse didUpdateLocation. Como faremos isso? Estamos recebendo aqui, por parâmetro, esse gerenciadorDeLocalizacao, então vamos nele, gerenciadorDeLocalizacao.delegate = self.

[02:16] Quando fazemos isso, ele vai reclamar, porque nós não implementamos o protocolo CL location manager delegate. Na verdade, o que precisamos é exatamente desse bloco de código aqui.

[02:32] Eu vou recortar, "Command + X", e vou colar ele dentro da nossa classe, "Command + V". A única coisa que precisamos mudar é isso aqui, estamos criando uma extension não de HomeViewController, mas sim de localização, então extension Localizacao que está implementando esse protocolo de delegate.

[02:54] Por enquanto nós vamos deixar assim, agora o que precisamos fazer é utilizar essa latitude e longitude no view controller. Nós precisamos criar, na verdade, um protocolo da localização para conseguirmos voltar essa informação para o view controller, depois que obtivermos a latitude e a longitude, precisamos devolver isso para o view controller.

[03:27] Vamos criar aqui esse protocolo. O nome dele será protocol LocalizacaoDelegate: AnyObject {}. Teremos um método aqui que vai se chamar func atualizaLocalizacaoDoUsuario(). Nós vamos passar a latitude, que é do tipo double, e a longitude, que é do tipo double, (latitude: Double, longitude: Double).

[04:03] Precisaremos criar uma variável do tipo desse protocolo, nós estamos usando aqui o design pattern que se chama delegate, então precisamos ter uma variável que acessemos fora dessa classe. Nós vamos criar ela agora. Aqui é importante a referência ser fraca, então weak var delegate:, do tipo do protocolo, : LocalizacaoDelegate?.

[04:31] Aqui embaixo, depois que obtivermos a latitude e a longitude, vamos então chamar esse protocolo, delegate?.atualizaLocalizacaoDoUsuario(). Vou passar a latitude e vou passar a longitude, (latitude: latitude, longitude: longitude).

[04:52] Aqui ele está reclamando porque a assinatura do método nós colocamos sem ser opcional, mas eu vou deixar aqui opcional, (latitude: Double?, longitude: Double?), e fazemos a validação na classe que implementar esse protocolo. Agora, o que nós vamos fazer aqui? Precisamos corrigir, na verdade, esse erro que ele está dando aqui, que é justamente porque não temos acesso ao gerenciador de localização.

[05:18] Mas nós temos acesso a esse manager, que é do mesmo tipo. Agora vamos voltar no "HomeViewController" para fazer algumas refatorações. A primeira coisa que nós vamos fazer será a implementação daquele protocolo que nós criamos, da localização, nós temos que implementar esse protocolo.

[05:43] Para implementar esse protocolo nós precisamos criar uma variável do tipo localização. Vamos lá, aqui nós temos o nosso lazy var gerenciadorDeLocalizacao, logo abaixo eu vou criar um private lazy var localizacao = e eu vou inicializar ela aqui, = Localizacao(). Agora, o que vamos fazer?

[06:11] Vamos utilizar essa variável localização em um método que vamos criar aqui embaixo, que ao invés de ser esse requisicaoDaLocalizacaoDoUsuario, o que vamos fazer aqui? Vamos utilizar a classe que nós criamos. Aqui eu vou apagar esse bloco, vou chamar a localizacao.delegate = self, então estamos implementando o protocolo que nós criamos.

[06:47] Estamos, na verdade, falando que nós vamos implementar esse protocolo. Ele vai reclamar porque vamos implementar ele agora. Vou criar um extension HomeViewController: e vou implementar o = LocalizacaoDelegate {}. Aqui nós temos acesso ao atualizaLocalizacaoDoUsuario.

[07:08] Além disso, precisamos chamar o método permissao. Esse método permissao, o que ele vai fazer Eu vou voltar um pouco, só para reutilizarmos o que estava aqui. Ele vai fazer exatamente isso aqui, é isso aqui que ele vai fazer.

[07:32] Vou dar um "Command + C", vou passar ele para baixo, onde nós vamos pedir a localização do usuário, igual nós estávamos fazendo lá. Agora vou dar um "Command + Shift + Z", e voltamos à implementação que nós fizemos.

[07:50] Aqui eu vou chamar a localizacao.permissao() e eu vou passar o (gerenciadorDeLocalizacao). Aqui embaixo, nós estamos atualizando a localização do usuário, nós teremos acesso à latitude e à longitude, o que vamos fazer? Vamos armazenar isso em uma variável, nós já temos aqui a latitude e a longitude, e o que vamos fazer é utilizar essas duas variáveis aqui.

[08:30] Latitude é igual à latitude que estamos recebendo por parâmetro, se vier nil nós setamos como 0, latitude = latitude ?? 0.0. E a longitude a mesma coisa, longitude - longitude ?? 0.0. Vou dar um "Command + B". Aqui ele está falando que a latitude, uma constante. Ele está pegando a referência dessa latitude do atualizaLocalizacaoDoUsuario.

[09:00] Então vamos fazer o seguinte, vou dar um self.latitude e um self.longitude, para pegarmos a referência das variáveis do view controller e não as que estamos recebendo por parâmetro.

[09:14] "Command + B", vamos ver se já está tudo buildando. Agora o que eu vou fazer? Eu vou rodar no meu iPhone para bater um ponto e verificar se realmente estamos salvando o recibo com a latitude e com a longitude. Eu vou colocar um breakpoint na linha 103 e vou rodar no meu iPhone para testarmos.

[09:42] Já espelhei o meu iPhone no Mac, então vamos fazer um teste. Vou clicar em "Registrar Ponto", tira uma foto, clico em "Use Photo" e agora temos acesso à latitude e à longitude. Vamos ver aqui, po latitude e po longitude.

[10:06] Olha que bacana, então nós vamos salvar e eu vou pôr um breakpoint nesse método onde nós estamos pegando a latitude que está vindo por parâmetro, tanto a latitude quanto a longitude, e estamos atribuindo à variável que nós temos da classe.

[10:40] Para vermos que realmente funcionou, eu vou clicar em "Recibo" e eu vou verificar se ele já está listando o recibo com a latitude e com a longitude. Vou abrir o "ReciboViewController", no método cellForRowAt, eu tenho acesso ao recibo.

[11:02] Vamos ver como está esse objeto recibo. Vou apagar todas as mensagens, po recibo?.latitude, po recibo?.longitude.

[11:20] Olha que bacana, nós já estamos com o acesso à localização do usuário. Agora, o próximo passo é continuarmos as implementações para conseguirmos exibir isso de fato no mapa.

@@05
Autorização de recursos

Estudamos na aula que, para utilizar alguns recursos do device (aparelho) como a câmera ou o GPS, precisamos de autorização do usuário.
Assinale as alternativas que explicam corretamente os tipos de au

.notDetermined: Esse status representa quando o usuário nega a utilização da localização.
 
Alternativa correta
.authorizedWhenInUse: Solicita autorização para usar serviços de localização somente quando o aplicativo está sendo executado.
 
Alternativa correta! Essa opção é utilizada para autorizar os recursos somente quando o aplicativo está sendo executado em primeiro plano.
Alternativa correta
requestAlwaysAuthorization: Solicita permissão para usar os serviços de localização sempre que o aplicativo está sendo executado.
 
Alternativa correta! Essa opção é utilizada para pedir autorização do usuário para o app utilizar sempre sua localização (mesmo estando em Standby).
Alternativa correta
.notDetermined: Solicita autorização do usuário a primeira vez que a feature é inicializada.
 
Alternativa correta! Essa opção é utilizada para pedir autorização para o usuário a primeira vez que ele entra na funcionalidade.

@@06
Faça como eu fiz: Localização do usuário

Neste capítulo, foi implementada uma nova regra de negócio que é a seguinte: toda vez que o usuário registra o ponto, devemos registrar também sua localização (latitude e longitude).
Como podemos fazer isso?

Depois de configurar a permissão da localização do usuário, podemos configurar os métodos de delegate da classe CLLocationManagerDelegate:
extension Localizacao: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let localizacao = locations.first {
            latitude = localizacao.coordinate.latitude
            longitude = localizacao.coordinate.longitude
        }

        delegate?.atualizaLocalizacaoDoUsuario(latitude: latitude, longitude: longitude)
    }
}

@@07
O que aprendemos?

Nessa aula, aprendemos como configurar o app para permitir que seja obtida a localização do usuário através da latitude e longitude.

#### 27/08/2023

@04-MapKit

@@01
Projeto da aula anterior

Se você deseja começar o curso a partir desta aula, pode fazer o download do projeto desenvolvido até o momento.

@@02
Trabalhando com Map Kit

[00:00] Terminamos a refatoração, extraímos do view controller para uma classe toda a lógica que nós precisamos, até o momento, para conseguir obter a latitude e a longitude do usuário. Agora vamos continuar com a criação do mapa, a ideia é nós implementarmos um mapa para mostrar a localização do usuário, então quando eu clicar em cima de um recibo, a ideia é abrir isso no mapa.
[00:33] A última coisa que nós vamos mexer nesse método permissao, que nós não fizemos na última aula, é tratar esse caso. Se o usuário já autorizar, se ele autorizar sempre ou autorizar enquanto o app estiver em uso, vamos utilizar esse método startUpdatingLocation, que é exatamente para começar a trackear a localização dele.

[00:58] Esse método vai disparar nesse didiUpdateLocations, que é um método de delegate e conseguimos então obter a localização do usuário. Então aqui nós temos o nosso gerenciadorDeLocalizacao, vamos dar um .startUpdatingLocation().

[01:22] Feito isso, nós vamos voltar ao nosso projeto, nós já temos algumas features, algumas funcionalidades, como a "Home", o "Recibo", agora vamos criar então uma outra pasta. Aqui, na estrutura principal do projeto, na pasta "Alura Ponto", botão direito, novo grupo, e vamos chamar aqui de "Mapa".

[01:47] Eu vou arrastar essa pasta "Mapa" para baixo da pasta "Recibo", tem que tomar cuidado para ele não entrar aqui, ela tem que ficar na mesma hierarquia de pastas. Na pasta "Mapa" eu vou criar mais duas pastas também, que vão, na verdade, nos ajudar a organizar o nosso projeto. Então botão direito, novo grupo, eu vou chamar de "View" e vou criar uma nova pasta, que eu vou chamar de "Controller".

[02:19] Nós temos as pastas "View" e "Controller". A ideia é criarmos um novo view controller, nós vamos fazer isso agora, em cima da pasta "Mapa > Controller", botão direito, novo arquivo, e vamos selecionar "Cocoa Touch Class", "Next". Se no seu Xcode não estiver pré-selecionado a opção subclasse de "UIViewController", você busque e clique em cima de "UIViewController".

[02:49] No meu caso já está. Eu vou dar então um nome para o arquivo, que se chamará "MapaViewController". Vamos manter essa opção para ele também criar uma view, que é o nosso XIB e eu vou dar um "Next" e um "Create". Só para manter a organização, ele cria tanto a view quanto o controller na mesma pasta, eu vou arrastar o meu XIB para dentro da pasta "View". Ficou assim.

[03:24] Antes de mexermos na parte visual, eu vou abrir o "MapaViewController" e vamos fazer algumas implementações. Começando aqui, eu vou apagar esses comentários, que ele já traz por padrão, vou apagar também esse outro comentário.

[03:41] Vamos criar um método para instanciar esse view controller. Como eu disse no início do vídeo, a ideia é que quando clicarmos em recibo, nós possamos abrir o mapa. Vamos criar um método para instanciar esse view controller. Eu vou criar uma class func, esse class significa que não precisamos instanciar o view controller para chamar o método.

[04:08] E o nome do método será class func instanciar() -> {}. Aqui é importante recebermos por parâmetro o recibo. Por que o recibo? Porque, na verdade, é o recibo que tem a latitude e a longitude, que são duas informações importantíssimas para nós utilizarmos no mapa. Por isso vamos receber ( recibo: Recibo?) -> por parâmetro.

[04:42] Eu vou receber um recibo opcional e eu vou devolver um -> MapaViewController {}. Aqui, qual é a ideia? Vamos criar um let controller =, que é um = MapaViewController() e vamos instanciar ele utilizando essa opção (nibName: " ", bundle: Bundle). nibName é o nome que nós demos para o nosso XIB, para o nosso XIB, que, coincidentemente, é o mesmo, "MapaViewController".

[05:19] Eu vou copiar o nome e colar ele aqui, (nibName: "MapaViewController". o bundle nós vamos passar bundle: nil, porque ele está dentro do mesmo pacote que nós estamos trabalhando, por isso é nil.

[05:33] Feito isso, já podemos dar um return controller. Mas o que vamos fazer com esse recibo que nós estamos recebendo por parâmetro? Nós vamos criar aqui uma variável dentro dessa classe, dentro desse view controller, para armazenar então o recibo. private var recibo:, que é do tipo : Recibo? opcional.

[05:58] Aqui eu pego controller.recibo = recibo que estamos recebendo por parâmetro, = recibo. Então temos aqui, só para manter organizado, vou criar um // MARK: - Atributos, aqui é onde // MARK: - Instanciar e o viewDidLoad faz parte do ciclo de vida do nosso app, // MARK: - View life cycle, ou ciclo de vida. E aqui embaixo nós temos o // MARK: - Métodos, que nós vamos implementar.

[06:44] Então já configuramos o nosso "MapaViewController", agora vamos voltar na "View" que nós temos aqui. Vamos colocar uma label, vou pegar uma label e vamos colocar um texto indicando o que esse mapa está nos mostrando. Vou colocar, por exemplo, "Localização da batida de ponto eletrônico".

[07:23] Vou centralizar, eu vou alterar algumas configurações de estilo, eu vou alterar a fonte, clique no quadrado ao lado da fonte, vou em fonte customizada. Nós vamos utilizar aqui a fonte, deixa eu ver, pode ser essa "Devanagari", negrito, então "Bold" e tamanho eu vou setar aqui "20".

[07:56] Vou deixar também em duas linhas. Em "Lines" eu vou colocar "2" e eu vou diminuir um pouco a largura e aumentar a altura para visualizarmos essa label em duas linhas. Vou centralizar. Agora precisamos adicionar algumas constraints.

[08:16] Para começar, o que eu vou fazer? Eu vou abrir o painel de constraints, na barra inferior, vou setar uma constraint de largura, que é esse primeiro checkbox e vou colocar 15 de altura. Agora eu vou abrir esse outro painel e vou centralizar a minha label na horizontal.

[08:38] E vou adicionar aqui. Então resolvemos todos os problemas das constraints. Agora sim, vamos utilizar o mapa. Eu vou buscar pelo mapa, map, na verdade. Vou clicar e vou arrastar para dentro da view e vou setar algumas constraints. Aqui nós colocamos uma altura de 15, então vou selecionar o mapa, vou colocar também uma altura de 15, para manter o padrão da label de cima.

[09:08] Margem esquerda 0, margem direita 0 e margem inferior 0. Cliquei em adicionar. Já temos o nosso mapa.

[09:22] Agora precisamos de fato chamar esse view controller. Eu vou no "ReciboViewContoller" e, para chamarmos esse mapa, nós precisamos implementar um método da UITableView, que é um método de delegate. Esse método se chama did select row.

[09:47] Ou seja, quando selecionamos uma linha na table view, é disparado esse método. O que vamos fazer? Primeiro eu preciso ter acesso ao recibo, porque, no fim das contas, o que vamos fazer é isso, nós vamos instanciar o mapa, let mapaViewController =. Eu vou instanciar ele aqui, = MapaViewController.instanciar(recibo: Recibo).

[10:10] Só que eu preciso passar, por parâmetro o recibo, então precisamos recuperar o recibo. let recibo = ao nosso = buscador.fetchedObjects?[], aqui vamos pegar no [indexPath.row], dessa forma temos acesso ao recibo.

[10:31] Eu vou passar o = MapaViewController(recibo) por parâmetro, e agora precisamos chamar esse view controller. Na verdade, eu quero chamar ele como um modal, então não vou utilizar, por exemplo, navigationController.pushViewController. Eu quero que essa tela abra de baixo para cima e consigamos ver o mapa. Como eu faço isso?

[10:54] Eu vou pegar o mapaViewController.modalPresentationStyle = e eu vou selecionar a opção = .automatic. Eu uso esse método present(), do próprio view controller e eu passo o (mapaViewController, animated: true, completion: nil), de forma animada.

[11:17] Então agora vamos rodar o projeto, para testar toda essa implementação que nós fizemos, eu vou utilizar o simulador do iPhone 11 mesmo, não tem nenhum problema. Vou clicar em "Recibos" e vou selecionar, por exemplo, o primeiro. Olha que bacana.

[11:34] Nós já estamos mostrando o mapa. Por enquanto não configuramos nenhuma localização para ele exibir, mas a ideia desse vídeo era construir esse modal para utilizarmos e, em seguida, conseguirmos mostrar a localização onde foi registrado o ponto. Para eu fechar esse modal eu clico nessa parte branca superior e arrasto para baixo. Dessa forma nós criamos o nosso modal com o mapa.

@@03
Colocando pinos no mapa

[00:00] Com o "MapaViewController" criado, nós vamos continuar as implementações nele, o que precisamos fazer agora? Nós já estamos exibindo o mapa, porém ele não está mostrando nenhuma região específica, então não faz sentido ainda exibirmos o mapa.
[00:20] A segunda coisa é exibir o pino no mapa onde a localização foi registrada, onde o usuário bateu e registrou o seu ponto. Então são duas coisas: mostrar a região e adicionar o pino, que é uma annotation no caso, no mapa. Vamos lá, para começar, aqui nós temos o nosso // MARK: - Métodos - só por curiosidade, todos esses marks que nós colocamos, se clicarmos em "MapaViewController", nós conseguimos encontrar as coisas mais fácil.

[01:00] Por exemplo, eu sei que os métodos estão aqui, eu clico e ele já me traz para o método. Os atributos, eu clico e ele me traz para os atributos. Então se agruparmos toda as coisas dentro de classes, controllers, fica muito mais fácil de darmos manutenção e fácil de encontrar as coisas. Imagine que, por exemplo, eu declaro uma variável aqui, depois eu declaro outro aqui, outra aqui, então começa a ficar bagunçado o nosso view controller.

[01:29] Eu, particularmente, gosto de separar e agrupar as coisas, assim nós conseguimos encontrar de uma forma mais simples. Vamos lá então, a primeira coisa que vamos fazer é criar um método chamado func setRegiao(), como nós estamos digitando aqui em português os métodos, e precisamos da latitude e da longitude.

[01:54] Como o nosso recibo é opcional, nós vamos começar extraindo os valores dessa variável, então eu vou criar um guard let latitude = e eu pego o = recibo.latitude, e também eu vou aproveitar o mesmo guard let para longitude, então mais uma vez, , let longitude = recibo.longitude else. Se eu não conseguir, eu dou um return e já encerro o método.

[02:33] Depois disso, vamos criar a região que nós vamos exibir no mapa. let regiao =, que é do tipo = MKCoordinate- aqui, no caso, nós precisamos importar o core location para trabalharmos com a API de localização e tudo mais. Porém, como precisaremos criar o outlet do mapa, e o mapa faz parte do map kit, eu vou importar o map kit, import MapKit.

[03:07] Quando eu importo o map kit ele automaticamente também importa o core location. Então = MKCoordinateRegion() e eu vou instanciar ele passando aqui dois parâmetros. Basicamente primeiro é esse (center:, que é esse : CLLocationCoordinate2D(), então eu vou instanciá-lo e passo a latitude e a longitude.

[03:35] A latitude nós já temos, que nós criamos um guard let para extrair esse valor, então vou passar a (latitude: latitude, longitude: longitude) e repare que nós precisamos de um span, que é esse span: MKCoordinateSpan. Nós vamos criar ele aqui em cima, let span = MKCoordinateSpan().

[04:01] Aqui nós temos, na verdade, dois valores, que nós temos que passar, e eu vou explicar na prática esses valores, que é um pouco mais fácil. Mas, na verdade, isso é tipo o zoom que queremos que o mapa exiba em cima da localização. Eu vou deixar um valor bem pequeno, tipo (latitudeDelta: 0.01, longitudeDelta: 0.01). Quando rodarmos no simulador eu aumento esse valor para você ver para que esse parâmetro serve.

[04:30] Com o span, eu vou passar ele por parâmetro, span: span. Então temos o span, temos a região, agora precisamos setar tudo isso no mapa. Para isso vamos criar o outlet do mapa, vou criar mais um //MARK: - IBOutlet. Eu vou abrir o nosso XIB, vou clicar em cima do mapa, vou em "Assistant".

[05:03] Aqui eu vou segurar a tecla "Control" do teclado e vou arrastar para o código. Vou nomear aqui como "mapa" e vou dar um "Connect". Feito isso, agora podemos voltar novamente no view controller, já temos uma referência da nossa view do mapa dentro do nosso view controller. Com isso, o que eu vou fazer?

[05:30] Eu vou pegar o mapa e eu vou dar um mapa.setRegion(). Eu vou passar a região que nós criamos, regiao, animated: true). O que eu vou fazer agora? Como nós já criamos esse método setRegiao, eu vou chamar ele no viewDidLoad, vou dar um setRegiao() e eu vou rodar o projeto para fazermos um teste.

[06:00] Vou clicar aqui, vou subir o simulador. Como eu estou utilizando o simulador, vou clicar nesse ícone de localização, para utilizarmos uma região. Eu vou escolher, por exemplo, "Rio de Janeiro". Se bem que aqui nós já tínhamos cadastrado e salvo a latitude e a longitude. Cliquei no recibo, ele não marcou nenhuma região. Vamos ver o outro recibo.

[06:43] Talvez quando salvamos esses recibos nós ainda não estávamos salvando a latitude e a longitude, então pode ser que não tenha valor. Quer ver? Deixa eu colocar um breakpoint, vou selecionar um recibo, deixa eu ver o valor da latitude e da longitude, po recibo.latitude, po recibo.longitude, é isso mesmo.

[07:17] Os dois valores estão 0, por isso ele não está exibindo nenhuma região. Daqui a pouco então vou testar com o meu iPhone físico, e conseguimos ver a região certa. O próximo passo, depois que setamos a região, o que eu vou fazer? Eu vou colocar um pino no mapa, que aqui chamamos de annotation, e podemos customizar ela, por exemplo, trocando o ícone, trocando o título.

[07:51] Mas, por default, por padrão, ele já vem com um balão e um alfinete. Nós vamos colocar essa marcação no mapa. Vamos lá, o que eu vou fazer aqui? Vou criar um novo método, vou chamar de func adicionarPino(). Aqui precisamos criar um annotation, eu vou chamar aqui de let annotation =, que é do tipo = MKPointAnnotation().

[08:28] Podemos colocar um título, annotation.title =, eu vou colocar ="Registro de ponto". Agora podemos passar, por exemplo, as coordenadas para essa annotation, annotation.coordinate.latitude = recibo?.latitude ?? 0.0. Se vier nil nós podemos fazer uma verificação aqui e setar 0.

[08:56] Aqui também annotation.coordintate.longitude = recibo.longitude 0.0. Se não houver valor nenhum, deixamos 0. Agora vamos adicionar essa annotation no mapa, eu vou chamar aqui o mapa.addAnnotation() e eu passo a (annotation) que nós criamos.

[09:19] Agora, para testarmos de verdade, eu vou conectar o meu iPhone e vamos realizar esse teste. Já espelhei o meu iPhone aqui no QuickTime, eu vou clicar em "Registrar ponto", vou clicar em "Usar foto" e eu tenho um registro. Eu vou clicar nesse card e ele mostra a localização que eu estou.

[09:51] Mas o pino do mapa ainda não apareceu. Nós precisamos chamar esse método também no viewDidLoad. Então adicionarPino(). Vou rodar mais uma vez. Eu já subi o simulador, vou clicar em "Recibo", clico em cima do registro e ele me mostra o ponto, o pino exatamente no local em que foi registrado o ponto.

[10:19] Então é dessa forma que trabalhamos com essas annotations. Na verdade, é muito simples, nós colocamos um título, nós temos também as coordenadas e nós também podemos colocar um subtítulo, se quisermos. Posso vir aqui, annotation.subtitle= " " e também colocar um texto qualquer.

[10:50] Tem outro ponto que eu queria mostrar aqui para você, que é: nós estamos trabalhando com a localização em cima da latitude e da longitude do usuário. Mas, no seu aplicativo, pode ser que você não tenha a latitude e a longitude, pode ser que você tenha que pedir para o usuário digitar uma localização, para ele pesquisar uma localização, e você descobre a latitude e longitude.

[11:17] Então você pode colocar um search ou alguma coisa assim no seu app, o usuário digita o local e é feita uma requisição para buscar esse endereço. Eu vou mostrar como fazer isso, não é o nosso caso, porque nós precisamos da localização atual do usuário, mas pode ser que no seu caso você precise utilizar isso.

[11:38] Aqui embaixo, só para fazermos esse teste, eu vou te mostrar. Nós temos um componente que se chama CL geo coder. Eu vou criar ele aqui, let geoCoder =, que é do tipo = CLGeocoder(). Podemos chamar ele e chamar esse método geoCoder.geocodeAddressString().

[12:00] Aqui eu passo, por exemplo, uma localização ("Avenida Paulista". Pode ser que isso o usuário digite, que é mais comum o usuário digitar, você pega a string que você receber e coloca neste parâmetro. Ele vai trazer aqui alguns locais, então { locaisEncontrados, error, ou ele pode trazer um erro, e você faz uma verificação.

[12:29] E como eu descubro a latitude e a longitude? Eu vou pegar a localização, que são esses locais encontrados, vou pegar o primeiro, let localizacao = locaisEncontrados?.first. Em cima dele eu vou criar a latitude, let latitude = localizacao?.location?.coordinate.latitude. A mesma coisa com a longitude, let longitude = localizacao?.location?.coordinate.longitude.

[13:03] Essa é uma forma em que o usuário inputa a rua, o endereço, a cidade, e você descobre a latitude e a longitude. Só para ilustrar aqui, já que estamos falando sobre localização, como você faria se você quisesse pesquisar a localização que o usuário procura. Com isso nós falamos então sobre mapas, sobre localização e já estamos exibindo os registros de ponto no mapa.

@@04
Configurando o pino do mapa

Quando trabalhamos com mapa, um recurso muito utilizado é o uso de uma View para marcar alguma referência, mais conhecida como Pino.
Qual dessas classe utilizamos para adicionar um novo pino no mapa?

CLLocationCoordinate2D.
 
Alternativa correta
MKCoordinateSpan.
 
Alternativa correta
MKPointAnnotation.
 
Alternativa correta! Através dessa classe, conseguimos adicionar uma View (pino) no local configurado.

@@05
Faça como eu fiz: Utilizando Mapas

O uso do MapKit nos permite utilizar vários recursos, dentre eles, o mapa, que utilizamos para exibir pontos importantes para o usuário.
Como podemos configurar um pino no mapa?

Para configurar um pino no mapa, usamos o seguinte código:
func adicionarPino() {
        let annotation = MKPointAnnotation()
        annotation.title = "Registro de ponto"

        annotation.coordinate.latitude = recibo?.latitude ?? 0.0
        annotation.coordinate.longitude = recibo?.longitude ?? 0.0

        mapa.addAnnotation(annotation)
}

@@06
O que aprendemos?

Nessa aula, aprendemos como implementar o mapa e também como configurá-lo para exibir pontos importantes para o usuário, através da classe MKPointAnnotation.

@05-Trabalhando com shortcuts

@@01
Projeto da aula anterior

Se você deseja começar o curso a partir desta aula, pode fazer o download do projeto desenvolvido até o momento.

@@02
Atalhos com shortcut

[00:00] Para finalizar o nosso curso, eu queria mostrar um recurso muito interessante que temos aqui disponível para utilizar nos aplicativos iOS, e se você é usuário iOS você já deve ter visto, que são os shortcuts. Vários apps, quando fazemos o clique um pouco mais forte em cima do ícone, por exemplo, aqui em "Contato", eu clico e seguro.
[00:26] Ele abre esse menu com algumas opções. Isso se chama shortcut e é muito interessante utilizarmos para melhorar a usabilidade do nosso aplicativo, então nós já conseguimos mostrar para o usuário algumas funcionalidades principais, para ele acessar, como, por exemplo, aqui no caso de contato, ele já pode adicionar um novo contato sem mesmo ter entrado no aplicativo.

[00:51] No caso, por exemplo, de apps bancários, a pessoa já pode entrar na tela de pagamentos, na tela de transferências. São realmente atalhos que podemos colocar no aplicativo. No nosso caso, nós vamos adicionar um shortcut para o usuário conseguir bater o ponto sem precisar abrir o app, clicar em registrar ponto, então vamos criar esse atalho para ele.

[01:14] Como trabalhamos com o shortcut? Nós vamos vir no "Info.plist", que nós temos aqui, e vamos configurar algumas coisas dentro desses registros que nós temos aqui. Para começar, eu vou adicionar um novo registro clicando no botão "+". Cliquei aqui, o registro que eu vou adicionar é esse "UIApplicationShortcutItems".

[01:47] Ele é do tipo "Array", então eu vou colocar array. Eu vou adicionar um novo item dentro desse array. Eu clico em adicionar no registro, ele vai adicionar um novo item. Esse novo item, ele tem que ser um "Dictionary", ele tem que ser um dicionário. Dentro dele vamos colocar algumas entradas como, por exemplo, o tipo.

[02:12] O tipo é para identificarmos em qual opção desse shortcut o usuário clicou, então pode ter mais do que uma. Por exemplo, se eu tenho a opção de registrar ponto, será um tipo, se eu tenho de deletar, será outro tipo. É como se fosse um ID para identificarmos qual opção o usuário clicou.

[02:30] Vamos lá, aqui eu vou nomear da seguinte maneira: "UIApplicationShortcutItemType" e eu vou colocar um valor para esse tipo, "RegistrarPonto". Nós temos que tomar muito cuidado porque esse mesmo valor nós vamos utilizar no enum que nós vamos criar, então tem que ser a validação utilizando exatamente esse valor.

[03:01] Vou adicionar mais uma opção, que é agora o ícone, então repare que quando fazemos o long press um pouco mais forte, ele abre um título e um ícone do lado. Então nós podemos configurar essas duas opções.

[03:19] Vamos voltar no nosso caso. Vamos utilizar um ícone que já existe no iOS, então "UIApplicationShortcutItemIconType". O nome do ícone, como é um ícone que já existe para o iOS, é o seguinte, "UIApplicationShortcutIconTypeCompose". Por último, vamos adicionar um título para essa opção, ou seja, qual é o título que nós queremos exibir. No caso do contato, "Create New Contact", esse é o título.

[04:02] No nosso caso, vamos colocar outro título, mas o título nós colocamos através desse registro "UIApplicationShortcutItemTitle" e o título podemos colocar qual título quisermos, no meu caso aqui, "Registrar ponto".

[04:29] Eu vou rodar o projeto, vou gerar um build no simulador. Vou voltar para a tela inicial, vou clicar e vou segurar. Nós já temos uma opção no nosso shortcut.

[04:46] "Registrar ponto", olha que bacana. Agora nós precisamos mexer na configuração de quando clicarmos em cima dessa opção. Onde ele cai quando eu clico em cima dessa opção? Ele cai em um método no SceneDelegate.

[05:03] Nós temos aqui um método, que se chama shortcutItem, é esse performActionFor shortcutItem. Quando clicamos lá, ele cai aqui. O que nós precisamos saber? Como aquele menu do shortcut ele pode ter várias opções, vários atalhos, nós precisamos saber em qual opção o usuário clicou.

[05:30] Por isso eu vou criar aqui um enum, só para mantermos um pouco mais organizado e, futuramente, se formos adicionar mais algumas opções, adicionamos no enum.

[05:40] enum TipoDeShortcut: String. Então case registrarPonto = aqui tem que ser exatamente igual a esse type que nós colocamos no "Info.plist", "RegistrarPonto". Eu vou até copiar e colar, porque tem que ser exatamente igual a esse registro. Eu coloco ele aqui, = "RegistrarPonto". E se tivermos mais opções no shortcut?

[06:13] É só adicionar mais um case, por exemplo, deletar registro, nós vemos o que colocamos no "Info.plist" de type e colocamos a mesma coisa aqui. Isso é o legal de trabalhar com enum nesse caso. Agora, o que vamos fazer? Vamos voltar nesse método performActionFor shortcutItem e primeiro vamos ver esse parâmetro shurtcutItem.

[06:43] shortcutItem.type é o tipo do shortcut que o usuário clicou. Então nós precisamos verificar se esse tipo existe no nosso enum, se existir, nós fazemos o que nós precisamos. Vou criar aqui um if let tipo =, ele é igual ao tipo do enum que nós criamos, = TipoDeShortchut(rawValue: ).

[07:03] No raw value eu passo rawValue: shortcutItem.type). Se existir, ele vai entrar aqui. Se entrar aqui, nós podemos fazer um switch tipo {} e tratar o caso case .registrarPonto:. Como só temos um caso por enquanto, esse default nós não vamos utilizar. Aqui, em .registrarPonto:, o que precisamos fazer?

[07:26] Precisamos navegar para a tela inicial e abrir a câmera, é isso o que vamos fazer. Só que não temos o navigation controller, quando criamos o aplicativo, ele cria como um tabBar, que é essa barra inferior.

[07:46] Tab bar é essa barra de menus aqui embaixo. O que vamos fazer? Nós vamos criar um navigation controller aqui embaixo do tabBarController para então utilizarmos nesse método para chamar o view controller que nós precisamos. Então eu vou criar um let navigationController =, que é um = UINavigationController().

[08:13] O (rootViewController: dele será o : tabBarController), que é a barra inferior com os os dois view controllers que nós temos. Nós precisamos ocultar o navigation bar, que é aquela barra que aparece em cima, eu vou até comentar essa parte do código só para buildar e te explicar.

[08:42] Aqui nós vamos fazer o seguinte, o window?.rootViewController =, ele será o = navigationController. Vou rodar aqui. Quando fazemos isso, repare que aqui em cima ele ficou com essa barra superior.

[09:00] Se eu clico no mapa, ele aparece essa barra em todos os controles, e eu não quero essa barra. Como eu faço para ocultar? Eu pego o navigationController.navigationBar.isHidden = true e passo como verdadeiro. Agora, se eu rodar o projeto, aquela barra não aparece mais lá.

[09:25] Ele serve para isso. Já tenho o meu navigation controller, agora o que vamos fazer? Vamos voltar e vamos tratar esse switch que nós temos aqui. Primeiro, o que eu vou fazer? Eu preciso do navigation aqui, eu preciso recuperar o navigation. Eu vou fazer o seguinte, eu vou criar uma constante let navigationController = window.rootViewController. rootViewController nós já vimos o que é, é o navigation controller.

[10:06] Então vamos fazer um casting para UINavigationController. Nós temos acesso aqui ao navigation. Depois disso, eu preciso ter acesso aos views controllers que nós temos no tab bar. Eu tenho a "Home" e tenho o "Recibo". Para eu não ter que instanciar de novo, para eu não ter que fazer isso let home = HomeViewController, aí eu instancio. Eu vou instanciar para que, se eu já tenho ele instanciado no meu aplicativo?

[10:46] Então eu vou utilizar o controller que já está inicializado, por isso eu não vou fazer dessa forma. Como eu faço então? Eu vou fazer o seguinte, eu vou criar um if let tabBarController =, afinal o view controller é dentro do tab bar, = navigationController?.viewControllers. firts, que é uma lista de view controllers e eu vou pegar o primeiro.

[11:15] E vou fazer o casting para UITabBarController. Se ele entrar aqui, significa que já temos o tab bar controller. O tab bar controller é esse componente inferior, que gerencia esses dois casos que nós temos aqui.

[11:37] O que eu vou fazer agora? Eu vou pegar o tabBarController. e vou dar um pop to view controller. Na verdade, é o navigationController.popToRootViewController(animated: true) e eu passo aqui como true. Esse método, ele volta no view controller inicial que foi instanciado. Qual é o view controller inicial que nós temos aqui?

[12:00] A "Home", então é isso o que eu estou fazendo aqui. Depois disso, eu tenho acesso então, de fato, ao primeiro view controller. Eu vou criar mais um if let, que é a home = tabBarController.viewControllers.first e eu vou fazer um casting para HomeViewController. Depois que eu voltei para o view controller inicial, que é a tela inicial do aplicativo.

[12:33] Porque pode ser que eu venha aqui, clique em "Recibo" e deixo o app suspenso, então eu preciso voltar para esse primeiro view controller para conseguir abrir a câmera. Depois que eu fizer isso de fato, o que eu vou fazer? Eu pego o home.tentaAbrirCamera().

[12:52] Esse é o trabalho que nós tivemos então para montar a lógica para abrir a câmera. Relembrando, eu não quis instanciar de novo os view controllers, porque nós já tínhamos eles inicializados, senão era muito simples eu instanciar a home, instanciar o recibo, mas não isso e nem é uma boa prática fazer isso. Nós já temos eles inicializados, por que vamos instanciar de novo?

[13:20] Dessa forma nós reaproveitamos os controles que nós já inicializamos para conseguir fazer o que nós precisamos aqui que, no fundo, é abrir a câmera. Agora, o que eu vou fazer? Eu vou plugar no meu iPhone e vou testar no meu iPhone físico, no meu device físico, para tentar abrir a câmera através do shortcut, porque, relembrando, no simulador, nós não conseguimos realizar algumas funcionalidades.

[13:48] Então eu vou fazer isso, eu vou conectar o meu iPhone e vamos testar. Eu já espelhei o meu iPhone no QuickTime, agora vamos fazer o teste. Eu vou voltar para a tela inicial e o que eu vou fazer aqui? Eu vou clicar e segurar e vou clicar em "Registrar ponto". Cliquei em "Registrar ponto", ele vai abrir a câmera. Então eu já posso registrar o ponto. Clico em "Usar foto" e nós temos aqui o registro. É dessa forma que trabalhamos com atalhos no iOS.

@@03
Configurando shortcuts

Como vimos na aula, podemos utilizar o recurso de 3D Touch para melhorar a usabilidade do usuário, colocando as principais features da aplicação em forma de atalho quando pressionamos o ícone do app com um pouco mais de força.
Em qual arquivo devemos implementar as chaves obrigatórias para habilitar esse recurso?

As keys (chaves) obrigatórias devem ser implementadas no arquivo Main.storyboard.
 
Alternativa correta
As keys obrigatórias devem ser implementadas no arquivo AppDelegate.
 
Alternativa correta
As keys obrigatórias devem ser implementadas no primeiro ViewController instanciado pela aplicação.
 
Alternativa correta
As keys obrigatórias devem ser implementadas no arquivo Info.plist.
 
Alternativa correta! Configuramos as opções do 3D Touch no arquivo Info.plist.

@@04
Faça como eu fiz: Configurando atalhos

Quando pressionamos um atalho no ícone do app, esse atalho nos leva a uma funcionalidade específica. Como podemos configurá-la?

Através do método performActionFor shortcutItem é que podemos configurar no SceneDelegate
func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

}

@@05
Projeto final do curso

Parabéns por chegar até aqui!
Você pode visualizar o projeto no Github ou até mesmo realizar o download dos arquivos.

https://github.com/alura-cursos/2316-alura-ponto-parte2

https://github.com/alura-cursos/2316-alura-ponto-parte2/archive/97149295535d3a9a209cc77862873a3907abd7ba.zip

@@06
O que aprendemos?

Nesta aula, aprendemos sobre:
Quais são as keys obrigatórias e opcionais para a implementação do 3D Touch;
Como é a implementação do 3D Touch.

@@07
Conclusão

[00:00] Parabéns!! Estamos finalizando mais um curso da nossa série de frameworks nativos para iOS. A ideia agora é relembrarmos tudo o que aprendemos neste curso, quais foram os principais tópicos. A ideia inicial foi mostrar para você como persistimos dados de forma local, então nós aprendemos a salvar imagens utilizando o File Manager.
[00:28] Então quando nós selecionamos uma imagem nós conseguimos persistir essa imagem no nosso aplicativo, sem ser utilizando o core data que foi uma das formas que nós aprendemos no curso anterior. Dessa vez eu quis mostrar para você como utilizamos o File Manager, que também é um recurso bem interessante.

[00:52] Quando falamos sobre o File Manager nós também contextualizamos o uso do core data, que ele é muito mais performático e ele é muito mais seguro para trabalhar com a persistência de informações maiores, informações onde você vai precisar fazer consultas um pouco mais específica, então é melhor você trabalhar com o core data.

[01:15] Porém, o File Manager é um recurso muito legal de se trabalhar quando precisamos persistir arbitrariamente algum arquivo, alguma foto, enfim, e assim nós utilizamos esse espaço no curso, essa oportunidade, para explorar um pouco mais sobre o uso do File Manager. Depois disso, nós aprendemos a utilizar a autenticação no local do iOS, que ela esse LocalAuthentication.

[01:45] Também contextualizamos que em aplicativos como aplicativos bancários, ou apps em que você precisa de um nível de permissão um pouco maior para o usuário, esse recurso também é muito utilizado. No nosso caso, nós aproveitamos os nossos cards de recibos.

[02:08] Nós temos esse botão deletar e nós aplicamos então essa funcionalidade justamente aqui, para o usuário conseguir apagar um recibo nós temos que autenticar e ver que é ele mesmo que está fazendo isso. Dessa forma conseguimos deixar um pouco mais seguras as configurações do nosso aplicativo.

[02:26] Depois começamos a falar um pouco sobre localização. Nós aprendemos a trabalhar com a localização do usuário, que é um recurso muito utilizado em aplicativos de corrida, de transporte, esses mais famosos, aplicativos de paquera, onde passamos por determinado trajeto e conseguimos ver as pessoas que estão lá.

[02:52] Tudo utilizando, na verdade, o GPS do iPhone, e que, no fundo, conseguimos trackear, desde que o usuário permita a localização dele. Então aprendemos a trabalhar com o core location, aprendemos a pedir a permissão do usuário para trackearmos a sua localização. A partir disso conseguimos obter a latitude e a longitude.

[03:18] No nosso caso foi bem útil, porque passamos a salvar a localização do usuário quando batemos o ponto, então a empresa fictícia, que nós estamos trabalhando para desenvolver esse aplicativo, consegue ver aonde foi que o usuário bateu o ponto, qual foi a localização.

[03:40] Depois disso, nós aprendemos um pouco também a mexer com o mapa do iOS. Criamos um controller específico para o mapa, para mostrar a localização do usuário. Aqui no simulador, nós não salvamos nenhuma localização, porque são batidas ponto antigas, mas conseguimos mostrar no mapa a região e o pino onde foi salvo esse ponto.

[04:10] Por último, nós falamos um pouco também sobre os atalhos do iOS. Quando eu clico e seguro, eu tenho esse menu de quick actions, onde nós podemos agregar atalhos.

[04:25] No nosso caso, nós conseguimos registrar um ponto sem estar com o app na tela do ponto ou sem inicializar o app. Dessa forma trabalhamos com o quick action, nós mexemos aqui no arquivo "Info.plist", configuramos algumas coisas.

[04:42] E no SceneDelegate também nós implementamos a lógica para mostrar os shortcuts. Esse foi o conteúdo que nós vimos durante este curso. Ao final você será direcionado à página de avaliação deste curso. Eu queria primeiro te parabenizar por chegar até a etapa final e espero que este curso tenha agregado os seus conhecimentos.

[05:08] Eu desejo que você continue praticando, que nós só conseguimos a excelência no nosso trabalho através de prática. Caso tenha uma aula que você tenha visto apenas uma vez, veja novamente.

[05:22] O que eu sempre indico é: pegue algum aplicativo que você goste e tente reproduzir as coisas que nós aprendemos no curso em cima desse projeto que você vai criar, que de verdade você estará exercendo e praticando tudo o que vimos aqui. Mais uma vez obrigado e até o próximo curso.
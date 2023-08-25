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
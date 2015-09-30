LOGIN_URL      = "https://www3.uninove.br/seu/aluno/"
LOGIN_POST_URL = "https://www3.uninove.br/seu/aluno/alu0002.php"

require 'mechanize'
require 'logger'

agent = Mechanize.new
agent.log = Logger.new "test.log"
agent.user_agent_alias = 'Mac Safari'

# Register some cookies
page = agent.get LOGIN_URL

# Make login,
# TODO: throw in error
page = agent.post LOGIN_POST_URL, {
  cSenha: ENV['password'],
  cLogin: ENV['login'],
  cChave: page.forms.first.fields.first.value,
  cAction: nil
}

# Student Info
student = {
  name: page.parser.css(".DivAluno p.txtNome").text,
  ra: page.parser.css(".DivAluno p.txtRA").text,
  image_url: page.parser.css(".DivAlunoFoto img").attr("src").value
}

puts student

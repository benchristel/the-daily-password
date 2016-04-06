require_relative './weighted_array'
require_relative './phrase_type'
require 'securerandom'

class Password
  def self.generate
    ROOT.choose
  end
end

ROOT = PhraseType.new(<<-__ROOT__
[two_word_animate_noun] [verb.singular] [two_word_noun]
[two_word_animate_noun_pl] [verb] [two_word_noun]
[three_word_animate_noun] [verb.singular] [noun]
[three_word_animate_noun.plural] [verb] [noun]
[animate] [verb.singular] [three_word_noun]
[animate.plural] [verb] [three_word_noun]
[three_word_phrase]; [who_cares]
__ROOT__
)

THREE_WORD_PHRASE = PhraseType.new(<<-__
[noun] [verb.singular] [one_word_object]
[noun.plural] [verb] [one_word_object]
__
)

ONE_WORD_OBJECT = PhraseType.new(<<-__
[noun]
[noun.plural]
__
)

WHO_CARES = PhraseType.new(<<-__
[last_name] [status]
[noun] [status]
__
)

TWO_WORD_ANIMATE_NOUN = PhraseType.new(<<-__
[noun] [animate]
[adjective] [animate]
[first_name] [last_name]
__
)

TWO_WORD_ANIMATE_NOUN_PL = PhraseType.new(<<-__
[noun] [animate.plural]
[adjective] [animate.plural]
__
)

THREE_WORD_ANIMATE_NOUN = PhraseType.new(<<-__
[adjective] [noun] [animate]
__
)

THREE_WORD_NOUN = PhraseType.new(<<-__
[adjective] [noun] [noun]
[loose_adjective] [tight_adjective] [noun]
__
)

TWO_WORD_NOUN = PhraseType.new(<<-__
[noun] [noun]
[adjective] [noun]
[last_name] [abstract]
__
)

NOUN = PhraseType.new(<<-__
[animate]
[inanimate]
[abstract]
__
)

ADJECTIVE = PhraseType.new(<<-__
[loose_adjective]
[tight_adjective]
__
)

TIGHT_ADJECTIVE = PhraseType.new(<<-__
Christian
Satanist
Jewish
pagan
Muslim
Buddhist
Hindu
Greek
white
black
hispanic
New York
Chicago
L.A.
San Fran
Canadian
American
European
Eurozone
Czech
German
French
Chinese
Romanian
__
)

LOOSE_ADJECTIVE = PhraseType.new(<<-__
beard
bearded
classist
racist
sexist
nationalist
labor
union
liberal
neocon
socialist
democratic
republican
international
overseas
cardigan
kombucha
spooky
doomed
controversial
challenged
difficult
alleged
local
toothy
angry
sleeping
restless
amorous
faceless
flaccid
wacko
unruly
terminal
barren
psycho
ninja
quack
wild
land
fresh
hairy
flaky
cracked
bad
bespoke
nervous
tight
sustainable
banned
eco-friendly
green
open-source
open
bohemian
foreign
homeless
viral
convicted
accused
doomed
obsolete
ancient
__
)

INANIMATE = PhraseType.new(<<-__
plane
software
egg
dope
cheese
pork
toast
beer
rhyme
fund
skeleton
bomb
steak
phone
cello
chair
bourbon
book
__
)

ANIMATE = PhraseType.new(<<-__
complainant
plaintiff
jury
head
lawyer
virus
senator
duck
pig
cow
cardinal
pope
magician
manager
actor
exec
marketer
aid
bassist
victim
prince
princess
king
queen
dog
cat
cow
wolf
CEO
__
)

ABSTRACT = PhraseType.new(<<-__
court
trial
law
religion
plague
innuendo
match
epidemic
scam
event
threat
play
show
sonnet
suit
head
float
toast
party
game
streak
trance
circus
drive
hiatus
debate
rumor
affair
stock
plan
alliance
debacle
parade
gift
game
__
)

STATUS = PhraseType.new(<<-__
shamed
shaken
perturbed
looks hopeless
jubilant
unfazed
discredited
disproven
overturned
__
)

VERB = PhraseType.new(<<-__
picket
frame
veto
elect
pass
miss
neglect
defy
flaunt
inspire
track
require
debut
talk down
rock
exclude
include
leave out
talk up
diss
defuse 
out
bankroll
disavow
crash
kidnap
steal
witness
watch
ditch
rescue
spark
receive
predict
foretell
foreshadow
stall
decline
dismiss
ban
strike
back
subpoena
summon
wring
edge
trounce
trump
drop
demo
unveil
awake
scratch
float
drift
tank
request
enter
land
wing
get
attack
bash
take
face
friend
google
book
dish
flame
pork
toast
stab
shank
upend
withhold
open
bank
thrash
whiff
nudge
dodge
head
lead
awe
shock
create
mastermind
rout
foreclose
upset
tax
demand
bomb
firebomb
fire
jinx
batter
__
)

FULL_NAME = PhraseType.new(<<-__
[FIRST_NAME] [LAST_NAME]
__
)

FIRST_NAME = PhraseType.new(<<-__
David
Gavin
Joanna
Anna
Don
Donny
Dolly
Frank
Franco
Mario
Luigi
Mike
Jerry
Jeff
Josh
Jesus
James
Marco
Christian
George
Joe
Alex
Steven
Steve
Dave
Stephen
Stephanie
Scott
Judy
Thomas
Tom
__
)

LAST_NAME = PhraseType.new(<<-__
Bowie
Krug
Brown
Klemmer
Walker
Parton
Franco
Mario
Newsom
Jaffa
McClure
McCormick
__
)

QUOTATIVE_PHRASE = PhraseType.new(<<-__
[quotative] [n_3]
__
)

QUOTATIVE = PhraseType.new(<<-__QUOTATIVE__
laments
wails
tells
reveals
says
claims
maintains
insists
alleges
confesses
moans
__QUOTATIVE__
)

INTRANSITIVE = PhraseType.new(<<-__
whiffs
retires
__
)

class Inflection
  def initialize(&block)
    @block = block
  end

  def apply(thing)
    @block.call(thing)
  end
end

SINGULAR = Inflection.new do |verb|
  if verb.end_with?('s', 'sh', 'ch', 'x')
    verb + 'es'
  else
    verb + 's'
  end
end

PLURAL = Inflection.new do |noun|
  if noun.end_with?('s', 'sh', 'ch', 'x')
    noun + 'es'
  else
    noun + 's'
  end
end

PAST = Inflection.new do |verb|
  if verb =~ /[aeiou][ptkdbg]$/
    verb = verb + verb[-1]
  end

  if verb.end_with?('e')
    verb + 'd'
  else
    verb + 'ed'
  end
end

puts "entropy: #{(ROOT.entropy / 10e8).round(2)} billion possibilities"
puts '------------'

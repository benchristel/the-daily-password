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
kombucha
hipster
labor
union
__
)

LOOSE_ADJECTIVE = PhraseType.new(<<-__
accused
alleged
amorous
ancient
angry
bad
banned
barren
beard
bearded
bespoke
bohemian
cardigan
challenged
classist
controversial
convicted
cracked
democratic
difficult
doomed
doomed
eco-friendly
estranged
faceless
flaccid
flaky
foreign
fresh
green
hairy
homeless
international
land
liberal
local
lucky
nationalist
neocon
nervous
ninja
obsolete
open
open-source
overseas
psycho
quack
racist
republican
restless
sexist
sleeping
socialist
spooky
sustainable
terminal
tight
toothy
unruly
viral
visionary
wacko
wild
__
)

INANIMATE = PhraseType.new(<<-__
plane
software
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
shrub
tree
__
)

ANIMATE = PhraseType.new(<<-__
complainant
plaintiff
outlaw
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
expat
terrorist
wizard
witch
__
)

ABSTRACT = PhraseType.new(<<-__
affair
alliance
backlash
break
circus
court
debacle
debate
drive
epidemic
event
float
game
game
gift
head
hiatus
innuendo
law
match
parade
party
plague
plan
play
religion
rumor
scam
show
sonnet
stock
streak
suit
threat
toast
trance
trial
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
attack
awake
awe
back
ban
bank
bankroll
bash
batter
bomb
book
break
crash
create
debut
decline
defuse 
defy
demand
demo
disavow
dish
dismiss
diss
ditch
dodge
drift
drop
edge
elect
enter
exclude
face
fire
firebomb
flame
flaunt
float
foreclose
foreshadow
foretell
frame
friend
get
google
head
hedge
include
inspire
jinx
kidnap
land
lead
leave out
mastermind
miss
neglect
nudge
open
out
pass
picket
pork
predict
receive
request
require
rescue
revive
rock
rout
scam
scratch
shank
shock
spark
stab
stall
steal
strike
subpoena
summon
take
talk down
talk up
tank
tax
thrash
toast
track
trounce
trump
unveil
upend
upset
veto
watch
whiff
wing
withhold
witness
wring
__
)

FULL_NAME = PhraseType.new(<<-__
[FIRST_NAME] [LAST_NAME]
__
)

FIRST_NAME = PhraseType.new(<<-__
Alex
Anna
Christian
Dave
David
Dolly
Don
Donny
Franco
Frank
Gavin
George
James
Jeff
Jerry
Jesus
Joanna
Joe
Josh
Judy
Luigi
Marco
Mario
Mike
Scott
Stephanie
Stephen
Steve
Steven
Thomas
Tom
__
)

LAST_NAME = PhraseType.new(<<-__
Adams
Allen
Anderson
Bailey
Baker
Barnes
Bell
Bennett
Bowie
Brooks
Brown
Butler
Campbell
Carter
Clark
Collins
Cook
Cooper
Cox
Cruz
Davis
Diaz
Edwards
Evans
Fisher
Flores
Foster
Franco
Garcia
Gomez
Gonzalez
Gray
Green
Gutierrez
Hall
Harris
Hernandez
Hill
Howard
Hughes
Jackson
Jaffa
Jenkins
Johnson
Jones
Kelly
King
Klemmer
Krug
Lee
Lewis
Long
Lopez
Mario
Martin
McClure
McCormick
Miller
Mitchell
Moore
Morales
Morris
Murphy
Myers
Nelson
Newsom
Nguyen
Ortiz
Parker
Parton
Perez
Perry
Peterson
Phillips
Powell
Price
Ramirez
Reed
Reyes
Richardson
Rivera
Roberts
Robinson
Rodriguez
Rogers
Ross
Sanchez
Sanders
Scott
Smith
Stewart
Sullivan
Taylor
Thomas
Thompson
Torres
Turner
Walker
Ward
Watson
White
Williams
Wilson
Wood
Wright
Young
martinez
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

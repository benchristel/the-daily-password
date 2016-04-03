require_relative './weighted_array'
require_relative './phrase_type'
require 'securerandom'

class Password
  def self.generate
    ROOT.choose
  end
end

ROOT = PhraseType.new(<<-__ROOT__
[five_word_verb_phrase]
__ROOT__
)
#[two_word_animate_noun_phrase] [verb.singular] [noun] [object]
#[adjective] [subject] [verb.singular] [adjective] [object]
#[noun] [subject] [verb.singular] [adjective] [object]
#[adjective] [subject] [verb.singular] [noun] [object]
#[three_word_verb_phrase], [animate] [quotative]
#[three_word_verb_phrase], [quotative] [animate]
#[animate] [quotative] [three_word_verb_phrase]
#[animate] [quotative] [subject] still [adjective]
#[subject], [subject] [verb] [adjective] [object]

THREE_WORD_VERB_PHRASE = PhraseType.new(<<-__
[subject] [verb.past] [object]
__
)

TWO_WORD_ANIMATE_NOUN_PHRASE = PhraseType.new(<<-__
[noun] [animate]
[adjective] [animate]
__
)

TWO_WORD_NOUN_PHRASE = PhraseType.new(<<-__
[two_word_animate_noun_phrase]
[adjective] [noun]
__
)

N2 = PhraseType.new(<<-__
[n2_2]
[n2_3]
[n2_4]
__
)

N3 = PhraseType.new(<<-__
[n3_4]
[n2_2] [n_3]
__
)

# two-word noun phrase with valence 2
N2_2 = PhraseType.new(<<-__
[n_1] [n_2]
[n_3]'s [n_2]
__
)

# two-word noun phrase with valence 3
N2_3 = PhraseType.new(<<-__
[n_1] [n_3]
[n_2] [n_3]
__
)

# two-word noun phrase with valence 4
N2_4 = PhraseType.new(<<-__
[n_1] [n_4]
[n_2] [n_4]
[n_3] [n_4]
[n_3]'s [n_4]
__
)

N2_2_3 = PhraseType.new(<<-__
[n2_2]
[n2_3]
__
)

N2_2_4 = PhraseType.new(<<-__
[n2_2]
[n2_3]
[n2_4]
__
)

N2_3_4 = PhraseType.new(<<-__
[n2_3]
[n2_4]
__
)

N3_3 = PhraseType.new(<<-__
[n2_2] [n_3]
__
)

N3_4 = PhraseType.new(<<-__
[n2_3] [n_4]
[n2_2] [n_4]
__
)

N = PhraseType.new(<<-__
[n_2]
[n_3]
[n_4]
__
)

# noun, valence 1
N_1 = PhraseType.new(<<-__
satanist
Christian
Jewish
pagan
Muslim
Buddhist
Hindu
Greek
white
black
hispanic
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
Chicago
New York
San Fran
L.A.
Canadian
American
Euro
Czech
British
German
French
Chinese
sustainable
eco-friendly
green
open-source
open
bohemian
homeless
viral
convicted
accused
doomed
__
)

N_2 = PhraseType.new(<<-__
plane
software
egg
dope
cheese
lawyer
pork
toast
beer
head
rhyme
skeleton
bomb
steak
phone
cello
__
)

N_3 = PhraseType.new(<<-__
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
bassist
victim
__
)

N_4 = PhraseType.new(<<-__
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
streak
trance
circus
drive
hiatus
debate
rumor
affair
hedge fund
stock
plan
alliance
debacle
parade
gift
__
)

FIVE_WORD_VERB_PHRASE = PhraseType.new(<<-__
[n2] rocks [n2_4]
[n3] rocks [n_4]
[n] rocks [n3_4]
[n2_3] talks down [n2]
[n2_3] talks up [n2]
[n2_3] defuses [n2_4]
[n2_3] outs [n2_3]
[n2_3] bankrolls [n2_3_4]
[n2_3] disavows [n2]
[n2_3] crashes [n2]
[n2_3] kidnaps [n2_2_3]
[n2_3] steals [n2_2]
[n2_3] witnesses [n2_2_4]
[n2_3] watches [n2_2_4]
[n2_3] ditches [n2_2_4]
[n2_3] rescues [n2_2_3]
[n2_3_4] sparks [n2_4]
[n2_3] receives [n2]
[n_3] receives [n3]
[n3_3] receives [n]
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

ADVERB = PhraseType.new(<<-__ADVERB__
still
never
always
__ADVERB__
)


QUOTATIVE = PhraseType.new(<<-__QUOTATIVE__
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

OBJECT = PhraseType.new(<<-__OBJECT__
[noun]
__OBJECT__
)

SUBJECT = PhraseType.new(<<-__SUBJECT__
[animate]
__SUBJECT__
)

ANIMATE = PhraseType.new(<<-__ANIMATE__
burglar
thief
mugger
monk
partisan
butler
chancellor
wrestler
dino
hipster
hippy
king
queen
prince
princess
horse
cow
dingo
baby
senator
mayor
wannabe
punk
rapper
fish
clown
actor
duck
tiger
goat
man
dog
wizard
candidate
president
minister
ambassador
diplomat
official
caliph
imam
cardinal
pope
pig
tourist
vigilante
weirdo
__ANIMATE__
)


VERB = PhraseType.new(<<-__VERB__
rock
dissuade
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
__VERB__
)

NOUN = PhraseType.new(<<-__NOUN__
alliance
comment
plan
plane
parade
software
hiatus
debate
rumor
affair
hedge fund
egg
dope
stock
cheese
lawyer
trance
circus
drive
pork
streak
toast
beer
float
head
rhyme
sonnet
play
show
suit
skeleton
bomb
scam
event
steak
__NOUN__
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

puts "entropy: #{ROOT.entropy}"
puts '------------'

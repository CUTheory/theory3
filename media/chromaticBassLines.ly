\version "2.14.2"

#(set-default-paper-size "letter")
#(set-global-staff-size 20)

\header {
	title = \markup { \smallCaps { "keyboard-style voice-leading" } }
	subtitle = \markup { \smallCaps { "bass lines" } }
	poet = ""
	composer = ""
	tagline = ""
	copyright = ""
	}

	\paper {
		myStaffSize = #20
		#(define fonts
	   (make-pango-font-tree  "Fanwood"
	                          "Nimbus Sans"
	                          "Luxi Mono"
	;;                        "Helvetica"
	;;                        "Courier"
	     (/ myStaffSize 20)))
	
	 	indent = 0.1\in
		top-margin = 0.5\in
		bottom-margin = 0.25\in
		line-width = 7.0\in
		ragged-right = ##f
		ragged-bottom = ##t
		ragged-last-bottom = ##f
		system-system-spacing #'minimum-distance = #35
		markup-system-spacing #'minimum-distance = #20
		score-system-spacing #'minimum-distance = #15
		last-bottom-spacing #'minimum-distance = #15
		%	page-count = #3
		print-page-number = ##f
	
	}

global = { 
	\override Score.PaperColumn #'keep-inside-line = ##t 	
	\override Staff.TimeSignature #'style = #'() 
	\set Staff.printKeyCancellation = ##f 
	\override Staff.TimeSignature #'break-visibility = #end-of-line-invisible
	\set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
	\set Staff.explicitClefVisibility = #end-of-line-invisible	

	% enter key signature, time signature, pickup length here
%	\key c \major
%	\time 2/2
%	\partial 8
	}

upper = \relative c'' {
	\clef treble
	<<
		{
			% enter melody here
			\override Score.RehearsalMark #'self-alignment-X = #LEFT
			\override Score.RehearsalMark #'Y-offset = #10
			\override Score.RehearsalMark #'font-size = #0
			
            
			} \\
			
		{
			% enter middle voices (alto & tenor) here
            
			}
		>>
	}

lower = <<
	\new Voice = "bass" <<
		\new FiguredBass \figuremode {
			\override BassFigure #'extra-offset = #'(0 . 12)
			
			% enter figures here within <> brackets
				% use + for sharp, - for flat, ! for natural
				% _ will make accidental by itself (apply to 3)
				% use s if bass note has no figure
				s2 <4 3> <6> <6> s <6 5> s <6 5> <6 4> <5 3> s1
				s2 <6> <4 2> <6> s <4 2> <6> <6 5> <4> <3> s1
				s2 <4/ 2> <6> <6/ 4 3> <_+> <6> <6-> <7 _+> s1
				s2 <6> <6> <6/> <_+> <4/ 2> <6> <6-> <6 4> <5 _+> s1
			
			}
		\relative c {
			\clef bass
			
			% enter bass line here
			\key g \major
			\time 2/2
			g2 a b c d dis e cis d d, g1 \bar "|." \break
			
			\key bes \major
			bes'2 a aes g f es d e f f, bes1 \bar "|." \break
			
			\key d \minor
			d'2 c b bes a f g a d,1 \bar "|." \break
			
			\key b \minor
			b'2 a g g fis e d e fis fis b,1 \bar "|." \break
			}
		>>
	>>

functionalBass = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
		
		% enter functional bass here, follwing the rules of lilypond lyrics
        "T{(1" "D2p" "3)" "S4" "D(5" "[+5])" "x6}" "[S+4]" "D5" "—" "T1"
		"T{1" "D7p" "[–]" "S6" "D(5" "4)" "3}" "[S+4]" "D5" "—" "T1"
		"T{(1" "[–7])" "S([+6]" "[–])" "D5" "3}" "[S4]" "D5" "T1"
		"T{1" "D7p" "S(6" "[6])" "D(5" "4)" "3}" "[S4]" "D5" "—" "T1"
		}
	}

functionalBassLower = {
	\set stanza = \markup { \normal-text "" }
		\lyricmode {
		
		% enter functional bass here, follwing the rules of lilypond lyrics
        \skip2 \skip2 \skip2 \skip2 \skip2 "D7/VI" \skip2 "D7/V" \skip2 \skip2 \skip2 
		\skip2 \skip2 "D4/IV" \skip2 \skip2 \skip2 \skip2 "D7/V" \skip2 \skip2 \skip2 
		\skip2 "D4/IV" \skip2 "Fr." \skip2 \skip2 "N." \skip2 \skip2 
		\skip2 \skip2 \skip2 "It." \skip2 \skip2 \skip2 "N." \skip2 \skip2 \skip2 
		}
	}

\score {
	\new PianoStaff \with { 
		\override StaffGrouper #'staff-staff-spacing #'minimum-distance = #15
		}
		<<
		\set PianoStaff.instrumentName = " "
		\set PianoStaff.shortInstrumentName = " "
		\set PianoStaff.midiInstrument = "piano" 
%		\new Staff = "Staff_pfUpper" << \global \upper >>
		\new Staff = "Staff_pfLower" << \global \lower >>
		\new Lyrics \lyricsto "bass" { \functionalBass }
    	\new Lyrics \lyricsto "bass" { \functionalBassLower }
		>>
	\layout { 
		\context { \Score \remove "Bar_number_engraver" }
		\context { \Staff \remove "Time_signature_engraver" }
    }
	}

module PafdsHelper
	def questions
		[
			{ activity: :gratitude, title: "1. Expressing gratitude:",
				description: "Counting your blessings for what you have (either to a 
					close other or privately, through contemplation or a journal) or 
					conveying your gratitude and appreciation to one or more individuals 
					whom you've never properly thanked." },
			{ activity: :optimism, title: "2. Cultivating optimism:",
				description: "Keeping a journal in which you imagine and write about the 
					best possible future for yourself or practicing to look at the bright 
					side of every situation." },
			{ activity: :comparison, title: "3. Avoiding overthinking and social comparison:",
				description: "Using strategies (such as distraction) to cut down on how 
					often you dwell on your problems and compare yourself to others." },
			{ activity: :kindness, title: "4. Practicing acts of kindness:",
				description: "Doing good things for others, whether friends or strangers, 
					either directly or anonymously, either spontaneously or planned." },
			{ activity: :relationships, title: "5. Nurturing relationships:",
				description: "Picking a relationship in need of strengthening, and 
					investing time and energy in healing, cultivating, affirming, and 
					enjoying it." },
			{ activity: :coping, title: "6. Developing strategies for coping:",
				description: "Practicing ways to endure or surmount a recent stress, 
					hardship, or trauma." },
			{ activity: :forgiveness, title: "7. Learning to forgive:",
				description: "Keeping a journal or writing a letter in which you work on 
					letting go of anger and resentment toward one or more individuals who 
					have hurt or wronged you." },
			{ activity: :engagement, title: "8. Doing more activities that truly engage you:",
				description: 'Increasing the number of experiences at home and work in 
					which you "lose" yourself, which are challenging and absorbing (i.e. 
					flow experiences).' },
			{ activity: :joys, title: "9. Savoring life's joys:",
				description: " Paying close attention, taking delight, and replaying 
					life's momentary pleasures and wonders, through thinking, writing, 
					drawing, or sharing with another." },
			{ activity: :goals, title: "10. Committing to your goals:",
				description: "Picking one, two, or three significant goals that are 
					meaningful to you and devoting time and effort to pursing them." },
			{ activity: :spirituality, title: "11. Practicing religion and spirituality:",
				description: "Becoming more involved in your church, temple, or mosque 
					or reading and pondering spiritually themed books." },
			{ activity: :body, title: "12. Taking care of your body:",
				description: "Engaging in physical activity, meditating, and smiling and 
					laughing." }
		]
	end
end

ActiveRecord::Base.connection.execute("DELETE FROM squares")

Square.create!(name: "Go")
Square.create!(name: "Jail")
Square.create!(name: "Free Parking")

GoToJailSquare.create!
IncomeTaxSquare.create!
SuperTaxSquare.create!

Chance.create!
CommunityChest.create!

StationProperty.create!(name: "Kings Cross Station")
StationProperty.create!(name: "Marylebone Station")
StationProperty.create!(name: "Fenchurch Street Station")
StationProperty.create!(name: "Liverpool Street Station")

UtilityProperty.create!(name: "Electric Company")
UtilityProperty.create!(name: "Water Works")

BrownProperty.create!(name: "Old Kent Road", price: 60, rent: 2, house_rent: [10, 30, 90, 160], hotel_rent: 250)
BrownProperty.create!(name: "Whitechapel Road", price: 60, rent: 4, house_rent: [20, 60, 180, 320], hotel_rent: 450)

BlueProperty.create!(name: "The Angel Islington", price: 100, rent: 6, house_rent: [30, 90, 270, 400], hotel_rent: 550)
BlueProperty.create!(name: "Euston Road", price: 100, rent: 6, house_rent: [30, 90, 270, 400], hotel_rent: 550)
BlueProperty.create!(name: "Pentonville Road", price: 120, rent: 8, house_rent: [40, 100, 300, 450], hotel_rent: 600)

PinkProperty.create!(name: "Pall Mall", price: 140, rent: 10, house_rent: [50, 150, 450, 625], hotel_rent: 750)
PinkProperty.create!(name: "Whitehall", price: 140, rent: 10, house_rent: [50, 150, 450, 625], hotel_rent: 750)
PinkProperty.create!(name: "Northumberland Avenue", price: 160, rent: 12, house_rent: [60, 180, 500, 700], hotel_rent: 900)

OrangeProperty.create!(name: "Bow Street", price: 180, rent: 14, house_rent: [70, 200, 550, 750], hotel_rent: 950)
OrangeProperty.create!(name: "Marlborough Street", price: 180, rent: 14, house_rent: [70, 200, 550, 750], hotel_rent: 950)
OrangeProperty.create!(name: "Vine Street", price: 200, rent: 16, house_rent: [80, 220, 600, 800], hotel_rent: 1000)

RedProperty.create!(name: "Strand", price: 220, rent: 18, house_rent: [90, 250, 700, 875], hotel_rent: 1050)
RedProperty.create!(name: "Fleet Street", price: 220, rent: 18, house_rent: [90, 250, 700, 875], hotel_rent: 1050)
RedProperty.create!(name: "Trafalgar Square", price: 240, rent: 20, house_rent: [100, 300, 750, 925], hotel_rent: 1100)

YellowProperty.create!(name: "Leicester Square", price: 260, rent: 22, house_rent: [110, 330, 800, 975], hotel_rent: 1150)
YellowProperty.create!(name: "Coventry Street", price: 260, rent: 22, house_rent: [110, 330, 800, 975], hotel_rent: 1150)
YellowProperty.create!(name: "Piccadilly", price: 280, rent: 24, house_rent: [120, 360, 850, 1025], hotel_rent: 1200)

GreenProperty.create!(name: "Regent Street", price: 300, rent: 26, house_rent: [130, 390, 900, 1100], hotel_rent: 1275)
GreenProperty.create!(name: "Oxford Street", price: 300, rent: 26, house_rent: [130, 390, 900, 1100], hotel_rent: 1275)
GreenProperty.create!(name: "Bond Street", price: 320, rent: 28, house_rent: [150, 450, 1000, 1200], hotel_rent: 1400)

PurpleProperty.create!(name: "Park Lane", price: 350, rent: 35, house_rent: [175, 500, 1100, 1300], hotel_rent: 1500)
PurpleProperty.create!(name: "Mayfair", price: 400, rent: 50, house_rent: [200, 600, 1400, 1700], hotel_rent: 2000)


ActiveRecord::Base.connection.execute("DELETE FROM cards")

AdvanceTo.create!(card_type: :community_chest, location: "Go")
Collect.create!(card_type: :community_chest, name: "Bank error in your favour - Collect $200", amount: 200)
Pay.create!(card_type: :community_chest, name: "Doctor's fees - Pay $50", amount: 50)
Collect.create!(card_type: :community_chest, name: "From sale of your stock you get $50", amount: 50)
GetOutOfJailFree.create!(card_type: :community_chest)
GoToJail.create!(card_type: :community_chest)
CollectFromAll.create!(card_type: :community_chest, name: "Grand Opera Opera - Collect $50 from every player for opening night seats", amount: 50)
Collect.create!(card_type: :community_chest, name: "Holiday Fund Matures - Receive $100", amount: 100)
Collect.create!(card_type: :community_chest, name: "Income tax refund - Collect $20", amount: 20)
CollectFromAll.create!(card_type: :community_chest, name: "It is your birthday - Collect $10 from each player", amount: 10)
Collect.create!(card_type: :community_chest, name: "Life insurance matures - Collect $100", amount: 100)
Pay.create!(card_type: :community_chest, name: "Pay hospital fees of $100", amount: 100)
Pay.create!(card_type: :community_chest, name: "Pay school fees of $150", amount: 150)
Collect.create!(card_type: :community_chest, name: "Receive $25 consultancy fee", amount: 25)
StreetRepairs.create!(card_type: :community_chest, name: "You are accessed for street repairs - $40 per house - $115 per hotel", per_house: 40, per_hotel: 115)
Collect.create!(card_type: :community_chest, name: "You have won second prize in a beauty contest - Collect $10", amount: 10)
Collect.create!(card_type: :community_chest, name: "You inherit $100", amount: 100)

AdvanceTo.create!(card_type: :chance, location: "Go")
AdvanceTo.create!(card_type: :chance, location: "Trafalgar Square")
AdvanceTo.create!(card_type: :chance, location: "Pall Mall")
AdvanceToUtility.create!(card_type: :chance)
AdvanceToStation.create!(card_type: :chance)
Collect.create!(card_type: :chance, name: "Bank pays you dividend of $50", amount: 50)
GetOutOfJailFree.create!(card_type: :chance)
GoBackThreeSpaces.create!(card_type: :chance)
GoToJail.create!(card_type: :chance)
StreetRepairs.create!(card_type: :chance, name: "Make general repairs on all your properties - For each house pay $25 - For each hotel pay $100", per_house: 25, per_hotel: 100)
Pay.create!(card_type: :chance, name: "Pay poor tax of $15", amount: 15)
AdvanceTo.create!(card_type: :chance, name: "Take a trip to Marylebone Station and if you pass Go collect $200", location: "Marylebone Station")
AdvanceTo.create!(card_type: :chance, name: "Advance to Mayfair", location: "Mayfair")
PayAll.create!(card_type: :chance, name: "You have been elected Chairman of the board - Pay each player $50", amount: 50)
Collect.create!(card_type: :chance, name: "Your building loan matures - Collect $150", amount: 150)
Collect.create!(card_type: :chance, name: "You have won a crossword competition - Collect $100", amount: 100)

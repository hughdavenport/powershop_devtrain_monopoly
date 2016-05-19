ActiveRecord::Base.connection.execute("DELETE FROM squares")

Square.create!(name: "Go")
Square.create!(name: "Jail")
Square.create!(name: "Free Parking")

GoToJailSquare.create!
IncomeTaxSquare.create!
SuperTaxSquare.create!

Square.create!(name: "Chance")
Square.create!(name: "Community Chest")

StationProperty.create!(name: "Kings Cross Station")
StationProperty.create!(name: "Marylbone Station")
StationProperty.create!(name: "Fenchurch Street Station")
StationProperty.create!(name: "Liverpool Street Station")

UtilityProperty.create!(name: "Electric Company")
UtilityProperty.create!(name: "Water Works")

BrownProperty.create!(name: "Old Kent Road", price: 60, rent: 2, house_rent: [10, 30, 90, 160])
BrownProperty.create!(name: "Whitechapel Road", price: 60, rent: 4, house_rent: [20, 60, 180, 320])

BlueProperty.create!(name: "The Angel Islington", price: 100, rent: 6, house_rent: [30, 90, 270, 400])
BlueProperty.create!(name: "Euston Road", price: 100, rent: 6, house_rent: [30, 90, 270, 400])
BlueProperty.create!(name: "Pentonville Road", price: 120, rent: 8, house_rent: [40, 100, 300, 450])

PinkProperty.create!(name: "Pall Mall", price: 140, rent: 10, house_rent: [50, 150, 450, 675])
PinkProperty.create!(name: "Whitehall", price: 140, rent: 10, house_rent: [50, 150, 450, 675])
PinkProperty.create!(name: "Northumberland Avenue", price: 160, rent: 12, house_rent: [60, 180, 500, 700])

OrangeProperty.create!(name: "Bow Street", price: 180, rent: 14, house_rent: [70, 200, 550, 750])
OrangeProperty.create!(name: "Marlborough Street", price: 180, rent: 14, house_rent: [70, 200, 550, 750])
OrangeProperty.create!(name: "Vine Street", price: 200, rent: 16, house_rent: [80, 220, 600, 800])

RedProperty.create!(name: "Strand", price: 220, rent: 18, house_rent: [90, 250, 700, 875])
RedProperty.create!(name: "Fleet Street", price: 220, rent: 18, house_rent: [90, 250, 700, 875])
RedProperty.create!(name: "Trafalgar Square", price: 240, rent: 20, house_rent: [100, 300, 750, 925])

YellowProperty.create!(name: "Leicester Square", price: 260, rent: 22, house_rent: [110, 330, 800, 975])
YellowProperty.create!(name: "Coventry Street", price: 260, rent: 22, house_rent: [110, 330, 800, 975])
YellowProperty.create!(name: "Piccadilly", price: 280, rent: 24, house_rent: [120, 360, 850, 1025])

GreenProperty.create!(name: "Regent Street", price: 300, rent: 26, house_rent: [130, 390, 900, 1100])
GreenProperty.create!(name: "Oxford Street", price: 300, rent: 26, house_rent: [130, 390, 900, 1100])
GreenProperty.create!(name: "Bond Street", price: 320, rent: 28, house_rent: [150, 450, 1000, 1200])

PurpleProperty.create!(name: "Park Lane", price: 350, rent: 35, house_rent: [175, 500, 1100, 1300])
PurpleProperty.create!(name: "Mayfair", price: 400, rent: 50, house_rent: [200, 600, 1400, 1700])

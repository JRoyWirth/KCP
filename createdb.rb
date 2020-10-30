# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :user do
  primary_key :id
  String :namefirst
  String :namelast
  String :email
  String :pwd
end

DB.create_table! :recipe do
  primary_key :id
  foreign_key :user_id
  String :program
  String :year
  String :section
  String :kwest
  String :title
  String :shortdesc
  String :whyrecipe, text: true
  String :location
  String :ingredients, text: true
  String :subs, text: true
  String :directions, text: true
  String :photo
  String :headshot
  String :meal
  Boolean :meatless
  Boolean :dairyfree
  Boolean :glutenfree
end

DB.create_table! :comment do
  primary_key :id
  foreign_key :user_id
  foreign_key :recipe_id
  Boolean :like
  String :comment, text: true
end

# Insert initial (seed) data
recipe_table = DB.from(:recipe)

recipe_table.insert(
                    user_id: "1",
                    program: "2Y",
                    year: "2021",
                    section: "Buckets",
                    kwest: "Amazing Race",
                    title: "Apple Crisp",
                    shortdesc: "Easy, seasonal dessert",
                    whyrecipe: "Growing up, we had a giant garden with Rhubarb and both pear and apple trees in our back yard. My wife jokes that picking from the garden was our family's version of video games. This recipe can be made with Apple (below), Pears or Rhubarb (for springtime)!",
                    location: "Illinois, U.S.A.",
                    ingredients: "5-6 apples, sliced (or 3 cups diced rhubarb) <br> 1.75 cups sugar <br> 1.2 tsp kosher salt <br> 1/2 cup watter (skip if using rhubarb) <br> cinnamon to taste <br> 1 stick of butter <br> 2 cups flour <br> 1/2 cup sugar",
                    subs: "use pears or rhubarb!",
                    directions: "1. Set oven to 350 degrees. Slice apples and place in the bottom of an 8-in square baking dish. Fill dish halfway with fruit.<br> 2. Sprinkle sugar and salt over the fruit. Add water (skip for rhubarb). <br> 3. Sprinkle cinnamon to taste over top. In a bowl, cut butter into flour and miz in 1/2 cup sugar until mixture is in crumbly bits. <br> 4. Sprinkle over fruit then pat down on top of fruit. <br> 5. Bake 40 minutes at 350 degrees.",
                    photo: "https://img.sndimg.com/food/image/upload/c_thumb,q_80,w_412,h_232/v1/img/recipes/13/32/56/picOcPO0X.jpg",
                    headshot: "",
                    meal: "Dessert",
                    meatless: "1",
                    dairyfree: "0",
                    glutenfree: "0"
                    )

recipe_table.insert(
                    user_id: "2",
                    program: "JV",
                    year: "2021",
                    section: "Buckets",
                    kwest: "Amazing Race",
                    title: "Challah",
                    shortdesc: "A bread for celebration!",
                    whyrecipe: "Over the years I have come to love to bake and this bread is one of my favorites to enjoy with friends and family to celebrate the jewish holidays or to enjoy for Friday night dinner and Saturday morning french toast!",
                    location: "Scottsdale, Arizona",
                    ingredients: "Sponge<br> 1c unbleached all purpose flour <br>1c water <br> 2 tsp instant yeast<br> Dough<br> 3.5c unbleached all purpose flour <br> 1.75 tsp kosher salt <br> 1/3c white sugar <br> 1/4c canola oil<br> 2 large eggs plus 1 yolk<br> Wash<br> 1 egg white<br> 1tsp sugar<br> 1tbsp water<br> 1 tsp Poppy Seeds or Sesame Seeds",
                    subs: "n/a",
                    directions: "1. Make sponge by mixing flour, water, and yeast together. Let stand for 60 minutes and add more time if your kitchen is below 70 degrees.<br> Make the dough by adding together ingredients to the sponge and kneeding it together until dough is formed into a smooth ball. Then place dough into a greased bowl and coat it lightly with oil. Cover and let stand until it has doubled in size. This will take 1.5 hours, longer if your kitchen is cold.<br> 3. Share the dough. The best way to explain this is with a video. It can be a lot of fun and creative! https://www.youtube.com/watch?v=V9OMJUfv_Ag <br> 4. Make the wash. In a new bowl, mix wash ingregients. Brush loaf with mixture and keep leftover wash. Cover loaf with plastic wrap and double in size again for another hour (again, more time if your kitchen is cold).<br> 5. Preheat oven to 375 degrees. Brush loaf with leftover egg wash and sprinkle with your choice of seeds. Bake for 35-40 minutes until bread is browned. Its helpful to have an oven thermometer in your oven to ensure proper the temperature. Remove bread from oven, let cool and enjoy! <br> Adapted from King Arthur Flour",
                    photo: "https://www.myjewishlearning.com/wp-content/uploads/2012/05/shutterstock_325872614.jpg",
                    headshot: "",
                    meal: "Side",
                    meatless: "1",
                    dairyfree: "1",
                    glutenfree: "0"
                    )

user_table = DB.from(:user)

user_table.insert(
                    namefirst: "Jason",
                    namelast: "Wirth",
                    email: "jason.wirth@kellogg.northwestern.edu",
                    pwd: BCrypt::Password.create("1234")
                    )

user_table.insert(
                    namefirst: "Sarah",
                    namelast: "Wirth",
                    email: "sarahnwirth@gmail.com",
                    pwd: BCrypt::Password.create("1234")
                    )


puts "Success!"
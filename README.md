# Explorations

## TODO

- separate the Exploration schema/model into all of its constituent JSON fields.
- mark random cities with the correct city name when saving them

## About

This is a little web application that uses ChatGPT to create a set of points of interest in a given (or randomly chosen) city, so you can enjoy looking at these sights in Google Streetview or Google Earth VR. It creates a backstory to go along with these waypoints, to give more context and interest to each one.

You'll get something like this:

```plaintext
1. City: Vienna, Austria\n\n

2. Background Story:\nSophie Müller is a 29-year-old graphic designer who specializes in creating branding and marketing materials for startups and small businesses. She grew up in Vienna, falling in love with its rich history and vibrant art scene. Sophie studied design at the University of Applied Arts Vienna, where she developed a strong passion for combining traditional elements of Austrian culture with modern design techniques. She enjoys exploring the city's artistic heritage and is an active participant in its local art community.\n\n

3. Socioeconomic Class:\nLower Middle Class - Sophie lives a modest lifestyle, balancing her freelance work with her small apartment in the city, which she decorates with thrifted and handcrafted decor. She often attends local workshops to stay engaged with the design community.\n\n

4. Home:\n**Address:** Währinger Straße 13, 1090 Vienna, Austria  \nSophie resides in a charming apartment located in the Alsergrund district, known for its historical buildings and proximity to Vienna's university area. The flat is small but cozy, filled with plants and artwork from local artists she admires.\n\n

5. Workplace:\n**Address:** Coworking Space, \"The Hub\", Landstraße 85, 1030 Vienna, Austria  \nSophie works from a collaborative coworking space where she meets with clients and other freelancers. The Hub is known for its creative atmosphere, offering a variety of events and networking opportunities that help her connect with the local startup scene.\n\n

6. Recreational Spots:\n1. **Park:** **Vötterl Park**, Währinger Straße 3, 1090 Vienna, Austria  \n   Just a short walk from her apartment, Sophie enjoys spending her mornings at Vötterl Park, where she takes her laptop to work outdoors or simply relaxes with a book. The park features colorful flowerbeds and plenty of seating areas, making it a perfect spot for freelancers like Sophie.\n\n2. **Favorite Café:** **Café Sperl**, Gumpendorfer Straße 11, 1060 Vienna, Austria  \n   On weekends, Sophie loves to unwind at Café Sperl, an iconic Viennese café known for its traditional coffee and pastries. The café's elegant décor and relaxed atmosphere provide her with inspiration for her designs.\n\n3. **Favorite Restaurant:** **Gasthaus Pöschl**, Wieden, 1010 Vienna, Austria  \n   After a long workweek, Sophie treats herself to dinner at Gasthaus Pöschl, a beloved spot for traditional Austrian cuisine. The cozy ambiance and hearty dishes make it a go-to place for locals.\n\n4. **Art Gallery:** **Kunst Haus Wien**, Löwengasse 16, 1030 Vienna, Austria  \n   Sophie frequently visits Kunst Haus Wien, an art museum dedicated to the works of Friedensreich Hundertwasser. The quirky architecture and contemporary exhibitions stimulate her creative ideas and renew her passion for design.\n\n### Google Earth VR Tour:\nFor an immersive exploration experience in Google Earth VR, follow Sophie’s typical day journey:\n\n1. Start at **Sophie’s Home**: Währinger Straße 13, 1090 Vienna.\n2. Drop by **Vötterl Park**: Währinger Straße 3, 1090 Vienna.\n3. Move to **The Hub** (Coworking Space): Landstraße 85, 1030 Vienna.\n4. Grab a coffee at **Café Sperl**: Gumpendorfer Straße 11, 1060 Vienna.\n5. Have dinner at **Gasthaus Pöschl**: Wieden, 1010 Vienna.\n6. End the day at **Kunst Haus Wien**: Löwengasse 16, 1030 Vienna.\n\nThis tour will give users a sense of Sophie’s life, her work environment, and her favorite spots in Vienna, allowing them to appreciate both the city and the perspectives of its residents."

```

## Try it out

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Run a postgres server, e.g. in a Docker container
- mix ecto.reset
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

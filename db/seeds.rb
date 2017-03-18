User.destroy_all

User.create(first_name: "Briana",
            last_name: "West",
            email: "bmwest@bu.edu",
            password: "admin1234",
            role: "admin")

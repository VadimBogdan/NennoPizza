#  Nenno's Pizza

## To launch the project open NennoPizza.xcworkspace and build NennoPizza scheme.

## App flow: Add pizzas and drinks then tap checkout on Cart sceen.

## BDD Specs

### Story: Customer requests to see menu of pizzas, theirs ingredients and prices

### Narrative

> As an online customer
I want the app to automatically load latest menu
So that I can see actual pizzas

### Acceptance criteria

```
Given the customer has connectivity
When the customer requests to see menu
Then the app should display the latest menu from remote
```

## Use Cases

### Load Pizzas Menu From Remote Use Case

#### Data:
- URL

#### Primary course (happy path): 
1. Execute "Load Pizzas Menu" command with above data.
2. System downloads data from url.
3. System validates downloaded data.
4. System creates pizzas menu from valid data.
5. System delivers pizzas menu.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

### Load Ingredients From Remote Use Case

#### Data:
- URL

#### Primary course (happy path): 
1. Execute "Load Ingredients" command with above data.
2. System downloads data from url.
3. System validates downloaded data.
4. System creates ingredients from valid data.
5. System delivers ingredients.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

### Calculate Pizza Price Use Case

#### Data:
- Base pizza price
- Ingredients
- Pizza ingredient ids

#### Primary course (happy path): 
1. System looks up a pizza's ingredient price from Ingredients using it's id.
2. System accumulate price of each pizza's ingredient.
3. System devliers price of a pizza ingredients + base price of a pizza.

#### Invalid pizza's ingredient id – error course (sad path):
1. System delivers base price of a pizza

---

## Model Specs

### Pizzas Menu

| Property      | Type                |
|---------------|---------------------|
| `pizzas`      | `Array<Pizza>`      |
| `basePrice`   | `Double`            |

### Pizza

| Property      | Type                |
|---------------|---------------------|
| `name`        | `String`            |
| `ingredients` | `Array<Int>`        |
| `url`         | `String` (optional) |

### Ingredients

| Property      | Type                |
|---------------|---------------------|
| `ingredients` | `Array<Ingredient>` |

### Ingredient

| Property      | Type                |
|---------------|---------------------|
| `price`       | `Double`            |
| `name`        | `String`            |
| `id`          | `Int`               |



### Payload contract

```
GET https://doclerlabs.github.io/mobile-native-challenge/pizzas.json

200 RESPONSE

{
    "basePrice": 4,
    "pizzas": [
        {
            "ingredients": [
                1,
                2
            ],
            "name": "Margherita",
            "imageUrl": "https://doclerlabs.github.io/mobile-native-challenge/images/pizza_PNG44095.png"
        },
        {
            "ingredients": [
                1,
                5
            ],
            "name": "Ricci",
            "imageUrl": "https://doclerlabs.github.io/mobile-native-challenge/images/pizza_PNG44092.png"
        }
        ...
    ]
}
```

---

```

GET https://doclerlabs.github.io/mobile-native-challenge/ingredients.json

200 RESPONSE

[
    {
        "price": 1,
        "name": "Mozzarella",
        "id": 1
    },
    {
        "price": 0.5,
        "name": "Tomato Sauce",
        "id": 2
    }
]
``

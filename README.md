# EfcRickMorty
SwiftUI / Combine / MVVM / Testing


1. [Descripción](#descripcion)
2. [Estructura](#estructura)
3. [NETWORK](#network)
4. [EndPoint](#endpoint)
5. [LiveMock](#livemock)
6. [Extension Color](#extensioncolor)
7. [Style](#style)
8. [Views](#views)
9. [ViewModifier](#viewmodifier)
10. [Testing](#testing)

## Descripción

**Este proyecto contiene dos features LIST and DETAIL.**

Este el flujo de navegacion desde la VIEW  a la llamada a la API

 VIEW -> VIEWMODEL -> USE CASE -> REPOSITORY 

Y este el flujo de navegación de la API a la VIEW.

 REPOSITORY -> USE CASE -> MAPPER -> VIEWMODEL -> VIEW 

Por el mismo camino hasta la VISTA inicial pasando por un MAPPER que modifica el valor de la respuesta a un formato ideal para el VIEWMODEL.

```swift

SwiftUI / Combine / MVMV 

View / Domain / Data / Repository

Mocks / Mapper / DTO 

Este proyecto contiene una arquitectura fácil de leer, mantener y testear.

Para testear se puede inyectar los servicios mocks (json) en lugar del servicio live (API).

```


## Estructura


**El propósito es llamar a : rickandmortyapi.com/api/ y mostrar la lista de personajes en la VIEW.**

| Carpeta | SubCarpeta  | Fichero | Descripción |
|--------------|--------------|--------------|--------------|
| List | | | |
|  | View | |  |
|  | | ListView  | Views components |
|  | | ListModel | Data para alimentar la vista |
|  | Domain | |  |
|  | | ListCaseUse  | Define metodo: getList: (String) -> AnyPublisher<ListModel, NetworkError> |
|  | | ListCaseLive | Implementa getList. Comunica con el Repository Live |
|  | | ListCaseMock | Implementa getList. Comunica con el  Repository Mock |
|  | Data | |  |
|  | | ListRepository  | Define methodo: getList: () -> AnyPublisher<ListDTO, NetworkError> |
|  | | ListRepositoryLive | LLama  -> CombineManager.shared.getData(endpoint: EndPoint.character(.all), type: ListDTO.self (Si la búsqueda contiene texto llama al endPoint Filter) |
|  | | ListRepositoryMock | Llama -> try! JSONDecoder().decode(ListDTO.self, from: jsonListDTO)  (Return MOCK ListDTO) |


## NETWORK


| Carpeta | SubCarpeta  | Fichero | Descripción |
|--------------|--------------|--------------|--------------|
| Network (Folder) | | | |
|  | URLSessionManager.swift|  | Metodo: getData<T: Decodable>(endpoint: EndPointProtocol, type: T.Type) Call API |
|  | URLRequestMethod.swift|  | Enum para utilizar en EndPoint e indicar si es GET, POST, ... |
|  | EndPoint.swift|  | Define endPoint con sus propiedades |
|  | Configuration| | |
|  | | Config | Estructura para la ConfigurationNet con propiedad baseUrl rickandmortyapi.com/api|
|  | | Configuration| Usa la Config struct. Este alimenta la propiedad baseURL en el EndPoint |
|  | Protocols| | |
|  | | EndPointProtocol | Define interface headers, method, urlString, parameters que el EndPoint debe de implementar |
|  | Error | | |
|  | | NetWorkError | Extend Error para capturar errorType |
|  | Mapper | | |
|  | | Mapper | Define método para mapper valores desde DTO al Model |




## EndPoint


En un enum gestiono la creación de los endPoints utilizados para llamar a la API.


```swift
enum EndPointType {
    case all
    case one(Int)
    case multiple([Int])
    case filter(String)
    case page(String)
    
    var route: String {
        switch self {
        case .all:
            return ""
        case .one (let id):
            return "/\(id)"
        case .multiple (let ids):
            return "/\(ids)"
        case .filter (let filter):
            return "/?name=\(filter)"
        case .page (let page):
            return "/?page=\(page)"
        }
    }
}

```

```swift
enum EndPoint: EndPointProtocol  {
    
    case character(EndPointType)
    case location(EndPointType)
    case episode(EndPointType)
    
    var headers: [String : String] {
        var headers: [String: String] = [:]
        headers["Accept"] = "application/json"
        headers["Accept-Language"] = "es"
        return headers
    }
    
    private var baseURL: String {
        return ConfigurationNet.shared.data.baseUrl
    }
    
    var urlString: String {
        switch self {
        case .character(let type), .location(let type), .episode(let type):
            return "\(baseURL)\(endPointType)\(type.route)"
        }
    }
    
    var parameters: [String : Any] {
        var params: [String: Any] = [:]
        switch self {
        case .character(.all):
               // params = ["page": 1] Example for use this property
               params = [:]
            default:
                break
        }
        
        return params
    }
    
    var method: String {
        switch self {
        case .character( _), .location( _), .episode( _):
            return URLRequestMethod.get.rawValue
        }
    }
    
    var endPointType: String {
        switch self {
        case .character:
            return "character"
        case .location:
            return "location"
        case .episode:
            return "episode"
        }
    }

}

```

# Live&Mock  


En el ViewModel se inyecta el caso de uso .live para llamar a la API.

En el ViewModel se inyecta el caso de uso .mock para utilizar los jsons mocks.

#### ListViewModel.swift

```swift
final class ListViewModel: ObservableObject {
    
    @Published var viewModelState: ViewModelState = ViewModelState.loadingView
    @Published var alertItem: AlertItem?
    @Published var searchText: String = ""
    @Published var clearSearchText: Bool = false
    
    private var listUseCase: ListUseCase
    private var task: Cancellable?
    private var cancellables = Set<AnyCancellable>()
  
    var characters: ListModel? = nil
    var charactersFiltered: ListModel? = nil

    init(listUseCase: ListUseCase = .live) { // CAMBIAR POR .mock para utilizar datos mock definidos en formato json
        self.listUseCase = listUseCase
        addSubscriberForComponents()
        getList()
    }

    ...

```

## Extension&Color


De esta manera defino los colores para aplicar a los componentes de la vista.

```swift
extension Color {
    static let themeOption = ColorThemeOption()
    static let themeCardDetail = ColorThemeCardDetail()
    static let themeItem = ColorThemeItem()
}

struct ColorThemeOption {
    let optionOne = Color("OptionOne")
    let optionTwo = Color("OptionTwo")
    let optionThree = Color("OptionThree")
    
    let unSelectedOption = Color("UnSelectedOption")
}

struct ColorThemeCardDetail {
    let header = Color("HeaderCard")
    let body = Color("BodyCard")
}

struct ColorThemeItem {
    let header = Color("HeaderItem")
    let body = Color("BodyItem")
}
```


## Style


Definido style para reutilizar.

```swift

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.heavy)
    }
}

struct CustomModifierCardDetailItem: ViewModifier {
    
    let colorBack: Color?
    let heightContent: CGFloat?
    
    init(colorBack: Color = Color.themeItem.header, heightContent: CGFloat = CGFloat(80) ) {
        self.colorBack = colorBack
        self.heightContent = heightContent
    }
    
    func body(content: Content) -> some View {
        content
            .frame(height: heightContent)
            .frame(maxWidth: .infinity)
            .background(colorBack)
            .foregroundColor(.white)
            .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .topRight]))
            .padding(.leading, 0)
            .padding(.trailing, 0)
        
    }
}

```

## Views


Esta es la pantalla que muestra el listado inicial y permite una búsqueda por nombre.


![Pantalla ListView](/pantallainicial400.png)





Búsqueda en la pantalla (ListView)
---

Introducir por lo menos tres carácteres y pulsar en la lupa para la búsqueda.


![Pantalla ListView](/pantallabusqueda.png)


Paginador en la pantalla
---

La primera petición obtiene de la peticiòn el info (pages) el número de páginas para generar botonera.

![Pantalla ListView](/pantallapaginador.png)

Página 20 seleccionada.


![Pantalla ListView](/pagina20.png)



Captura pantalla (Custom component)
---

Esta captura de pantalla muestra el componente customizado ItemCharacter.

Es un diseño que he visto y he implementado el código desde cero.


![Componente creado](/ItemListRickMorty.png)

Enums para uso de Emoji  
---

Utilización de enums para mostrar Emoji en lujar de texto

```Swift
enum StatusCharacter {
    case alive
    case dead
    case unknown
    
    var iconDescription: String? {
        switch self {
        case .alive: return "🕺"
        case .dead: return "💀"
        case .unknown: return "?"
        }
    }
}
```

```Swift
enum GenderCharacter {
    case female
    case male
    case unknown
    
    var iconDescription: String? {
        switch self {
        case .female: return "👩‍⚖️"
        case .male: return "🤵‍♂️"
        case .unknown: return "?"
        }
    }
}
```

Lo aplico en la pantalla de detalle.

![Pantalla ListView](/pantalladetalle.png)

![Pantalla ListView](/statusdead.png)

![Pantalla ListView](/genderfemale.png)


## ViewModifier
---

Estaba aplicando un estilo tanto a CardDetail como a ItemCharacter. 

He creado un Modifier con al que se puede pasar un color de fondo a aplicar. 

De esta manera he reducido código redundante.

```Swift

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.heavy)
    }
}

struct CustomModifierCardDetailItem: ViewModifier {
    
    let colorBack: Color?
    let heightContent: CGFloat?
    
    init(colorBack: Color = Color.themeItem.header, heightContent: CGFloat = CGFloat(80) ) {
        self.colorBack = colorBack
        self.heightContent = heightContent
    }
    
    func body(content: Content) -> some View {
        content
            .frame(height: heightContent)
            .frame(maxWidth: .infinity)
            .background(colorBack)
            .foregroundColor(.white)
            .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .topRight]))
            .padding(.leading, 0)
            .padding(.trailing, 0)
        
    }
}

```


## Testing


Creado test para comprobar que se recibe de la API correctamente el id del listado inicial de personajes.

Creado test para comprobar que es correcto la petición de la página número 3.



```Swift

final class TestListFeature: XCTestCase {

    var sut: CombineManager!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = CombineManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testGetList_idFirst_equal_one() throws {

        let expectation = self.expectation(description: "Espera el resultado de la API")
        
        let cancellabe = sut.getData(endpoint: EndPoint.character(.all), type: ListDTO.self).sink (
            receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { response in
                    XCTAssertEqual(response.results[0].id, 1)
                })
            
            waitForExpectations(timeout: 10, handler: nil)
            cancellabe.cancel()
    
    }

    func testGetList_pageNumberThree_previousTwo_nextFour() throws {

        let previousUrl = "https://rickandmortyapi.com/api/character/?page=2"
        let nextUrl = "https://rickandmortyapi.com/api/character/?page=4"
        
        let expectation = self.expectation(description: "Espera el resultado de la API")
        
        let cancellabe = sut.getData(endpoint: EndPoint.character(.page("3")), type: ListDTO.self).sink (
            receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { response in
                    XCTAssertEqual(response.info.prev, previousUrl)
                    XCTAssertEqual(response.info.next, nextUrl)
                })
            
            waitForExpectations(timeout: 10, handler: nil)
            cancellabe.cancel()
        
    }

}


```

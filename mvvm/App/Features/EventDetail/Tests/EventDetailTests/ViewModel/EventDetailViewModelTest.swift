import XCTest
import Model
@testable import EventDetail

class EventDetailViewModelHappyCaseTest: XCTestCase {
    internal var viewModel: EventDetailViewModel!
    
    override func tearDown() {
        viewModel = nil
    }
    
    func test_return_correct_event_icon_name_for_normal_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .event,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_correct_event_icon_name_for_default_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .defaultCase,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event_default"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_correct_event_icon_name_for_every_day_health_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .everyDayHealth,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event_daily_health"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_correct_event_icon_name_for_check_in_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .checkIn,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event_check_in"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_correct_event_icon_name_for_check_out_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .checkOut,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event_check_in"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_correct_event_icon_name_for_portfolio_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .portfolio,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event_portfolio"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_correct_event_icon_name_for_story_published_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .storyPublished,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event_portfolio"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_correct_event_icon_name_for_story_exported_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .storyExported,
                                                eventSnapshot: "")
        viewModel = EventDetailViewModel(event: event)
        let expectedValue = "ic_event_portfolio"
        //Assign
        let actual = viewModel.getIconName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
}

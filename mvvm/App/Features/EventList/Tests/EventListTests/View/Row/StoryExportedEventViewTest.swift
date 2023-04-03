//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
import SwiftUI
import Model
import ViewInspector
import AttributedText
@testable import EventList

class StoryExportedEventViewTests: XCTestCase {
    private var usecase : EventListUseCase!
    internal let mockService = MockFailCaseEventListNetworkService()
    internal let coordinator = MockCoordinator()
    internal var viewModel: EventListViewModel!


    override func setUp() {
        usecase = EventListUseCase(networkService: mockService)
        viewModel = EventListViewModel(eventListUseCase: usecase, coordinator: coordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        usecase = nil
    }
    
    func test_happy_case_for_story_exported_event_view() throws {
        //Arrange
        let event = EventModel.init(id: 5,
                                    insertedAt: "2022-07-07T15:07:6",
                                    eventDate: "2022-07-07T15:07:6",
                                    eventDescription: "You have a Story PDF ready for download.",
                                    eventType: .storyExported,
                                    eventSnapshot: "{\"exp\":\"2022-07-14T06:58:34\",\"school_id\":20544,\"url\":\"https://s3.ap-southeast-1.amazonaws.com/ll.staging/preview/b87348c9-1317-4d11-a484-e487ec5df8e3.pdf\"}")
        let snapshot = event.getSnapshotInstance() as! StoryExportedEventSnapshot
        let expectedValue = "You have a Story PDF ready for download. b87348c9-1317-4d11-a484-e487ec5df8e3.pdf"
        let expectedValueTitle = "event.row.portfolio".localizedString(Bundle.module).uppercased()
        //Assign
        let view = StoryExportedEventView(event: event, snapshot: snapshot, viewModel: viewModel)
        let value = try view.inspect().vStack().vStack(1).text(0).string()
        let valueTitle = try view.inspect().vStack().hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }
}

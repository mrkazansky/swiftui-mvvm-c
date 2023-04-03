//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
@testable import Model

final class StoryExportedSnapshotTests: XCTestCase {
    func test_return_correct_file_name(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .storyExported,
                                                eventSnapshot: "{\"exp\":\"2022-07-14T06:58:34\",\"school_id\":20544,\"url\":\"https://s3.ap-southeast-1.amazonaws.com/ll.staging/preview/b87348c9-1317-4d11-a484-e487ec5df8e3.pdf\"}")
        let expectedValue = "b87348c9-1317-4d11-a484-e487ec5df8e3.pdf"
        //Assign
        let actual = (event.getSnapshotInstance() as! StoryExportedEventSnapshot).getFileName()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
}

#encoding: utf-8
Feature: Implementing the create a new movie sequence.  

	Scenario: Adding new movie
		Given I am on the RottenPotatoes home page
		When I follow "Add New Movie"
		Then I should be on the Create New Movie page
		When I fill in "Title" with "Men In Black"
		And I select "PG-13" from "Rating"
		And I press "Save Changes"
		Then I should be on the RottenPotatoes home page
		And I should see "Men In Black"
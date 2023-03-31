require 'rails_helper'

RSpec.describe "Projects Show Page" do
 
  describe "visit a project's show page" do
    before(:each) do
      @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
      @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

      @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
      @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


      ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
      ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)

    end
    it "I see that project's name and material" do
      visit "/projects/#{@upholstery_tux.id}"

      expect(page).to have_content("Project Name: #{@upholstery_tux.name}")
      expect(page).to have_content("Project Material: #{@upholstery_tux.material}")

      visit "/projects/#{@lit_fit.id}"

      expect(page).to have_content("Project Name: #{@lit_fit.name}")
      expect(page).to have_content("Project Material: #{@lit_fit.material}")

      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Project Name: #{@news_chic.name}")
      expect(page).to have_content("Project Material: #{@news_chic.material}")

      visit "/projects/#{@boardfit.id}"

      expect(page).to have_content("Project Name: #{@boardfit.name}")
      expect(page).to have_content("Project Material: #{@boardfit.material}")
    end
    it "I see the theme of the challenge that this project belongs to" do
      visit "/projects/#{@upholstery_tux.id}"

      expect(page).to have_content("Challenge Theme: #{@furniture_challenge.theme}")

      visit "/projects/#{@lit_fit.id}"

      expect(page).to have_content("Challenge Theme: #{@furniture_challenge.theme}")

      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Challenge Theme: #{@recycled_material_challenge.theme}")

      visit "/projects/#{@boardfit.id}"

      expect(page).to have_content("Challenge Theme: #{@recycled_material_challenge.theme}")
    end

    it "I see a count of the number of contestants on this project" do
      visit "/projects/#{@upholstery_tux.id}"
 
      expect(page).to have_content("Number of Contestants: #{@upholstery_tux.contestant_count}")
      
      visit "/projects/#{@lit_fit.id}"

      expect(page).to have_content("Number of Contestants: #{@lit_fit.contestant_count}")
      
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Number of Contestants: #{@news_chic.contestant_count}")
      
      visit "/projects/#{@boardfit.id}"

      expect(page).to have_content("Number of Contestants: #{@boardfit.contestant_count}")

    end

    it "I see the average years of experience for contestants that
        worked on that project" do

      visit "/projects/#{@upholstery_tux.id}"
     
      expect(page).to have_content("Average Years of Experience: #{@upholstery_tux.contestant_avg_exp}")
      
      visit "/projects/#{@lit_fit.id}"

      expect(page).to have_content("Average Years of Experience: #{@lit_fit.contestant_avg_exp}")
      
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Average Years of Experience: #{@news_chic.contestant_avg_exp}")
      
      visit "/projects/#{@boardfit.id}"

      expect(page).to have_content("Average Years of Experience: #{@boardfit.contestant_avg_exp}")

    end
  end
end


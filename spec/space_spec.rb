require('spec_helper')

describe('Space') do
  context('after running seeds file') do
    it('will find the space by coordinates and return the room type') do
      expect((Space.find_by(coordinates: 'I10')).space_type).to(eq('Study'))
    end
  end
end

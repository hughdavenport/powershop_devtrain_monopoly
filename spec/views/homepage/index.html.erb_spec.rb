require 'rails_helper'

RSpec.describe "homepage/index.html.erb", type: :view do
  before { render }
  subject { rendered }

  it { is_expected.to have_link('New Game', href: new_game_path) }

  it { is_expected.to have_link('List Games', href: games_path) }
end

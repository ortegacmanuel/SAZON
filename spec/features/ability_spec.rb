require "cancan/matchers"
require 'rails_helper'

describe Ability do\
  subject(:ability){ Ability.new(user) }
  let(:user){ nil }

  context "when is an admin" do
    let(:user){ create(:user, :admin) }

    # can acces but not delete all
    %i[read create update].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, :all) }
    end

    # can view documents
    %i[view].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Document.new) }
    end

    # can destroy Begrip Assignment and Image
    %i[destroy].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Begrip.new) }
      it{ is_expected.to be_able_to(action.to_sym, Assignment.new) }
      it{ is_expected.to be_able_to(action.to_sym, Image.new) }
    end
  end

  context "when is an student" do
    let(:user){ create(:user, :student) }

    # can read Begrip Assignment and Image
    %i[read].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Document.new) }
      it{ is_expected.to be_able_to(action.to_sym, Assignment.new) }
      it{ is_expected.to be_able_to(action.to_sym, Begrip.new) }
    end

    # can view documents
    %i[view].each do |action|
      it{ is_expected.to be_able_to(action.to_sym, Document.new) }
    end

    # cannot create update delete index to all
    %i[create, update, delete, index].each do |action|
      it{ is_expected.not_to be_able_to(action.to_sym, :all) }
    end
  end
end

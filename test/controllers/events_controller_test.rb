require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { comments: @event.comments, date_time: @event.date_time, fireteam_group_type: @event.fireteam_group_type, fireteam_leader: @event.fireteam_leader, level: @event.level, system: @event.system, video_url: @event.video_url }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { comments: @event.comments, date_time: @event.date_time, fireteam_group_type: @event.fireteam_group_type, fireteam_leader: @event.fireteam_leader, level: @event.level, system: @event.system, video_url: @event.video_url }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end

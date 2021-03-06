# app/controllers/admin_track_controller.rb:
# Show email alerts / RSS feeds from admin interface.
#
# Copyright (c) 2008 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/

class AdminTrackController < AdminController
    def list
        @query = params[:query]
        @admin_tracks = TrackThing.paginate :order => "created_at desc", :page => params[:page], :per_page => 100,
            :conditions =>  @query.nil? ? nil : ["lower(track_query) like lower('%'||?||'%')", @query ]
        @popular = ActiveRecord::Base.connection.select_all("select count(*) as count, title, info_request_id from track_things join info_requests on info_request_id = info_requests.id where info_request_id is not null group by info_request_id, title order by count desc limit 10;")
    end

    private

end

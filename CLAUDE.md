# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Tech Stack

- **Framework**: Rails 5.2.3, Ruby 2.5.3
- **Database**: PostgreSQL
- **Frontend**: Webpacker, Bootstrap 4, jQuery
- **Authentication**: Devise
- **Authorization**: Pundit
- **Maps/Navigation**: Mapbox GL JS, Google Places API
- **Geocoding**: Geocoder gem
- **Image Uploads**: Cloudinary + Carrierwave

## Development Commands

```bash
# Install dependencies
bundle install
yarn install

# Database setup
rails db:create
rails db:migrate
rails db:seed

# Run development server
rails server

# Run console
rails console

# Run tests
rails test
rails test test/models/itinerary_test.rb  # Single test file
```

## Environment Variables

Required in `.env` (never commit this file):
- `GOOGLE_API_SERVER_KEY` - Google Places API key
- `MAPBOX_API_KEY` - Mapbox API key
- `CLOUDINARY_URL` - Cloudinary configuration
- `PRODUCTION_HOST` - Production domain (production only)

## Architecture Overview

### Core Models & Relationships

**User → UserCategory → Category**: Users select categories (Live Music, Art, Parks, Nightlife, Museums, Attractions) for their preferences

**Itinerary → Result → Event**: Join table pattern where:
- `Itinerary` belongs to `User`, has location/radius/time preferences
- `Result` is the join table (TODO: should be renamed to `ItineraryEvent`)
- `Event` belongs to `Category`, has many `Review`s

The `Result` model is a join table connecting itineraries to events. There's a known TODO to rename it to `ItineraryEvent` for clarity (requires migration).

### Service Layer Pattern

**GooglePlacesService** (`app/services/google_places_service.rb`):
- `search(itinerary)` - Fetches places for each user category from Google Places API
- `place_details(place_id, itin, cat_id)` - Gets detailed info for a place
- `build_event(event, itin, cat_id)` - Creates Event and Result records from API response
- `find_reviews(event_google, event_id)` - Creates Review records from Google reviews
- `generate_itin(itinerary)` - Filters events by available time and calculates routes

**MapboxNavService** (`app/services/mapbox_nav_service.rb`):
- `direct(itin_array)` - Gets walking directions for array of events
- `direct_a_to_b(starting, ending)` - Gets walking directions between two points

### Key Flow: Itinerary Generation

1. User searches for location (geocoded via Geocoder gem) → `ItinerariesController#new`
2. User selects preferences (radius, time, categories) → Form submission
3. `ItinerariesController#create`:
   - Calls `build_user_categories` to create UserCategory records
   - Saves Itinerary with geocoded coordinates
   - Calls `GooglePlacesService.search(itinerary)` to fetch and save Events
4. `ItinerariesController#show`:
   - Calls `GooglePlacesService.generate_itin(@itinerary)` to filter events by time
   - Calls `MapboxNavService.direct(@itin_events)` for navigation
   - Renders map with Mapbox GL JS

### Authorization

Uses Pundit policies. All controller actions require authorization via `authorize @resource`. Policies in `app/policies/`.

### Geocoding

Both `Itinerary` and `Event` models use geocoding:
- `Itinerary` geocodes `:location` (city/place name) on save
- `Event` has latitude/longitude from Google Places API (geocoding disabled)

## Known TODOs

Remaining TODOs requiring architectural changes:
- **Line itineraries_controller.rb:16** - Move itinerary generation from `show` to `create` action
- **Line itineraries_controller.rb:66** - Define user categories in `new` action instead of `create`
- **Line google_places_service.rb:14** - Check if Google Places API supports multiple categories in one request
- **Line google_places_service.rb:31** - Implement background jobs (ActiveJob) for API calls
- **Line google_places_service.rb:86** - Rename `Result` model to `ItineraryEvent` (requires migration)

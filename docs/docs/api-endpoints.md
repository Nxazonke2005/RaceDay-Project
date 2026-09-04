| Method | Route | Description | Role | Request Body | Response |
|--------|-------|-------------|------|--------------|----------|
| POST | /api/auth/register | Register user | None | {email, password, name} | 201 Created |
| POST | /api/auth/login | Login user | None | {email, password} | 200 OK |
| GET | /api/events | Get all events | Any | None | 200 OK |
| POST | /api/events | Create event | Organiser | {name, date, location} | 201 Created |
| GET | /api/events/{id} | Get one event | Any | None | 200 OK |
| PUT | /api/events/{id} | Update event | Organiser | {name, date, location} | 200 OK |
| DELETE | /api/events/{id} | Delete event | Organiser | None | 204 No Content |
| POST | /api/events/{id}/enrol | Enrol in event | Participant | None | 201 Created |
| GET | /api/enrolments | My enrolments | Participant | None | 200 OK |
| POST | /api/events/{id}/results | Add results | Organiser | {participantId, time} | 201 Created |

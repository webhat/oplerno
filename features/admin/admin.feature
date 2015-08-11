Feature: Admin Browse

	Scenario Outline: Admin looks at admin#index
		* I am not authenticated as an AdminUser
		* I am a AdminUser
		* I login as an AdminUser
		* I look at the <clazz>s page
		* It succeeds

		Examples:
			| clazz     |
      | Team      |
      | Mentor    |
			| Cart			|
			| Invite		|
			| InviteCredit			|
			| AdminUser |
		  | Course		|
			| Order			|
			| Comment		|
			| Skill			|
			| Setting	|
			| Subject		|
			| User			|
			| OrderTransaction			|
			| Certificate |

	Scenario Outline: Admin looks at admin#show
		* I am not authenticated as an AdminUser
		* I am a AdminUser
		* I login as an AdminUser
		* I look at the first <clazz>
		* It succeeds

		Examples:
			| clazz     |
      | Team      |
      | Mentor    |
			| Cart			|
		  | Course		|
			| Order			|
			| Skill			|
			| Setting	|
			| Subject		|
			| User			|
			| AdminUser |
			| Certificate |

	Scenario Outline: Admin looks at admin#edit
		* I am not authenticated as an AdminUser
		* I am a AdminUser
		* I login as an AdminUser
		* I look at the edit <clazz>
		* It succeeds

		Examples:
			| clazz     |
      | Team      |
      | Mentor    |
			| Cart			|
		  | Course		|
			| Order			|
			| Skill			|
			| Setting	|
			| Subject		|
			| User			|
			| AdminUser |
			| Certificate |

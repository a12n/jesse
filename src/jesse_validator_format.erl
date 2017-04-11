-module(jesse_validator_format).

%% API
-export([ check_custom_format/3
        ]).

%% Includes
-include("jesse_schema_validator.hrl").

%%% API
-spec check_custom_format( Value :: jesse:json_term()
                         , Format :: binary()
                         , State :: jesse_state:state()
                         ) -> jesse_state:state().
check_custom_format(Value, Format, State) ->
  CustomFormats = jesse_state:get_custom_formats(State),
  case lists:keyfind(Format, 1, CustomFormats) of
    false -> State;
    {_, IsValid} ->
      case IsValid(Value) of
        true  -> State;
        false -> jesse_error:handle_data_invalid(?wrong_format, Value, State)
      end
  end.

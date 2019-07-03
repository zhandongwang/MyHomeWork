# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'date'
require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module ClouddebuggerV2
      
      class Debuggee
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StackFrame
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListBreakpointsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Variable
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SourceLocation
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GerritSourceContext
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class FormatMessage
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegisterDebuggeeResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GetBreakpointResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AliasContext
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CloudWorkspaceId
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Breakpoint
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetBreakpointResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListActiveBreakpointsResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ExtendedSourceContext
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RegisterDebuggeeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RepoId
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProjectRepoId
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CloudWorkspaceSourceContext
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ListDebuggeesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CloudRepoSourceContext
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateActiveBreakpointRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SourceContext
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Empty
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GitSourceContext
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class StatusMessage
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateActiveBreakpointResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Debuggee
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          property :project, as: 'project'
          collection :ext_source_contexts, as: 'extSourceContexts', class: Google::Apis::ClouddebuggerV2::ExtendedSourceContext, decorator: Google::Apis::ClouddebuggerV2::ExtendedSourceContext::Representation
      
          property :description, as: 'description'
          property :is_disabled, as: 'isDisabled'
          property :status, as: 'status', class: Google::Apis::ClouddebuggerV2::StatusMessage, decorator: Google::Apis::ClouddebuggerV2::StatusMessage::Representation
      
          property :is_inactive, as: 'isInactive'
          property :agent_version, as: 'agentVersion'
          hash :labels, as: 'labels'
          property :uniquifier, as: 'uniquifier'
          collection :source_contexts, as: 'sourceContexts', class: Google::Apis::ClouddebuggerV2::SourceContext, decorator: Google::Apis::ClouddebuggerV2::SourceContext::Representation
      
        end
      end
      
      class StackFrame
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :locals, as: 'locals', class: Google::Apis::ClouddebuggerV2::Variable, decorator: Google::Apis::ClouddebuggerV2::Variable::Representation
      
          property :function, as: 'function'
          property :location, as: 'location', class: Google::Apis::ClouddebuggerV2::SourceLocation, decorator: Google::Apis::ClouddebuggerV2::SourceLocation::Representation
      
          collection :arguments, as: 'arguments', class: Google::Apis::ClouddebuggerV2::Variable, decorator: Google::Apis::ClouddebuggerV2::Variable::Representation
      
        end
      end
      
      class ListBreakpointsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :breakpoints, as: 'breakpoints', class: Google::Apis::ClouddebuggerV2::Breakpoint, decorator: Google::Apis::ClouddebuggerV2::Breakpoint::Representation
      
          property :next_wait_token, as: 'nextWaitToken'
        end
      end
      
      class Variable
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :var_table_index, as: 'varTableIndex'
          property :status, as: 'status', class: Google::Apis::ClouddebuggerV2::StatusMessage, decorator: Google::Apis::ClouddebuggerV2::StatusMessage::Representation
      
          collection :members, as: 'members', class: Google::Apis::ClouddebuggerV2::Variable, decorator: Google::Apis::ClouddebuggerV2::Variable::Representation
      
          property :name, as: 'name'
          property :value, as: 'value'
          property :type, as: 'type'
        end
      end
      
      class SourceLocation
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :path, as: 'path'
          property :line, as: 'line'
        end
      end
      
      class GerritSourceContext
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :host_uri, as: 'hostUri'
          property :alias_name, as: 'aliasName'
          property :alias_context, as: 'aliasContext', class: Google::Apis::ClouddebuggerV2::AliasContext, decorator: Google::Apis::ClouddebuggerV2::AliasContext::Representation
      
          property :gerrit_project, as: 'gerritProject'
          property :revision_id, as: 'revisionId'
        end
      end
      
      class FormatMessage
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :parameters, as: 'parameters'
          property :format, as: 'format'
        end
      end
      
      class RegisterDebuggeeResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :debuggee, as: 'debuggee', class: Google::Apis::ClouddebuggerV2::Debuggee, decorator: Google::Apis::ClouddebuggerV2::Debuggee::Representation
      
        end
      end
      
      class GetBreakpointResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :breakpoint, as: 'breakpoint', class: Google::Apis::ClouddebuggerV2::Breakpoint, decorator: Google::Apis::ClouddebuggerV2::Breakpoint::Representation
      
        end
      end
      
      class AliasContext
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :kind, as: 'kind'
          property :name, as: 'name'
        end
      end
      
      class CloudWorkspaceId
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :repo_id, as: 'repoId', class: Google::Apis::ClouddebuggerV2::RepoId, decorator: Google::Apis::ClouddebuggerV2::RepoId::Representation
      
          property :name, as: 'name'
        end
      end
      
      class Breakpoint
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :id, as: 'id'
          collection :stack_frames, as: 'stackFrames', class: Google::Apis::ClouddebuggerV2::StackFrame, decorator: Google::Apis::ClouddebuggerV2::StackFrame::Representation
      
          property :location, as: 'location', class: Google::Apis::ClouddebuggerV2::SourceLocation, decorator: Google::Apis::ClouddebuggerV2::SourceLocation::Representation
      
          property :status, as: 'status', class: Google::Apis::ClouddebuggerV2::StatusMessage, decorator: Google::Apis::ClouddebuggerV2::StatusMessage::Representation
      
          property :user_email, as: 'userEmail'
          property :condition, as: 'condition'
          property :final_time, as: 'finalTime'
          property :action, as: 'action'
          hash :labels, as: 'labels'
          property :log_message_format, as: 'logMessageFormat'
          property :create_time, as: 'createTime'
          property :log_level, as: 'logLevel'
          collection :evaluated_expressions, as: 'evaluatedExpressions', class: Google::Apis::ClouddebuggerV2::Variable, decorator: Google::Apis::ClouddebuggerV2::Variable::Representation
      
          property :is_final_state, as: 'isFinalState'
          collection :expressions, as: 'expressions'
          collection :variable_table, as: 'variableTable', class: Google::Apis::ClouddebuggerV2::Variable, decorator: Google::Apis::ClouddebuggerV2::Variable::Representation
      
        end
      end
      
      class SetBreakpointResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :breakpoint, as: 'breakpoint', class: Google::Apis::ClouddebuggerV2::Breakpoint, decorator: Google::Apis::ClouddebuggerV2::Breakpoint::Representation
      
        end
      end
      
      class ListActiveBreakpointsResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :wait_expired, as: 'waitExpired'
          collection :breakpoints, as: 'breakpoints', class: Google::Apis::ClouddebuggerV2::Breakpoint, decorator: Google::Apis::ClouddebuggerV2::Breakpoint::Representation
      
          property :next_wait_token, as: 'nextWaitToken'
        end
      end
      
      class ExtendedSourceContext
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          hash :labels, as: 'labels'
          property :context, as: 'context', class: Google::Apis::ClouddebuggerV2::SourceContext, decorator: Google::Apis::ClouddebuggerV2::SourceContext::Representation
      
        end
      end
      
      class RegisterDebuggeeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :debuggee, as: 'debuggee', class: Google::Apis::ClouddebuggerV2::Debuggee, decorator: Google::Apis::ClouddebuggerV2::Debuggee::Representation
      
        end
      end
      
      class RepoId
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :project_repo_id, as: 'projectRepoId', class: Google::Apis::ClouddebuggerV2::ProjectRepoId, decorator: Google::Apis::ClouddebuggerV2::ProjectRepoId::Representation
      
          property :uid, as: 'uid'
        end
      end
      
      class ProjectRepoId
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :repo_name, as: 'repoName'
          property :project_id, as: 'projectId'
        end
      end
      
      class CloudWorkspaceSourceContext
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :snapshot_id, as: 'snapshotId'
          property :workspace_id, as: 'workspaceId', class: Google::Apis::ClouddebuggerV2::CloudWorkspaceId, decorator: Google::Apis::ClouddebuggerV2::CloudWorkspaceId::Representation
      
        end
      end
      
      class ListDebuggeesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :debuggees, as: 'debuggees', class: Google::Apis::ClouddebuggerV2::Debuggee, decorator: Google::Apis::ClouddebuggerV2::Debuggee::Representation
      
        end
      end
      
      class CloudRepoSourceContext
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :alias_name, as: 'aliasName'
          property :alias_context, as: 'aliasContext', class: Google::Apis::ClouddebuggerV2::AliasContext, decorator: Google::Apis::ClouddebuggerV2::AliasContext::Representation
      
          property :repo_id, as: 'repoId', class: Google::Apis::ClouddebuggerV2::RepoId, decorator: Google::Apis::ClouddebuggerV2::RepoId::Representation
      
          property :revision_id, as: 'revisionId'
        end
      end
      
      class UpdateActiveBreakpointRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :breakpoint, as: 'breakpoint', class: Google::Apis::ClouddebuggerV2::Breakpoint, decorator: Google::Apis::ClouddebuggerV2::Breakpoint::Representation
      
        end
      end
      
      class SourceContext
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cloud_repo, as: 'cloudRepo', class: Google::Apis::ClouddebuggerV2::CloudRepoSourceContext, decorator: Google::Apis::ClouddebuggerV2::CloudRepoSourceContext::Representation
      
          property :cloud_workspace, as: 'cloudWorkspace', class: Google::Apis::ClouddebuggerV2::CloudWorkspaceSourceContext, decorator: Google::Apis::ClouddebuggerV2::CloudWorkspaceSourceContext::Representation
      
          property :git, as: 'git', class: Google::Apis::ClouddebuggerV2::GitSourceContext, decorator: Google::Apis::ClouddebuggerV2::GitSourceContext::Representation
      
          property :gerrit, as: 'gerrit', class: Google::Apis::ClouddebuggerV2::GerritSourceContext, decorator: Google::Apis::ClouddebuggerV2::GerritSourceContext::Representation
      
        end
      end
      
      class Empty
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class GitSourceContext
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :url, as: 'url'
          property :revision_id, as: 'revisionId'
        end
      end
      
      class StatusMessage
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :is_error, as: 'isError'
          property :description, as: 'description', class: Google::Apis::ClouddebuggerV2::FormatMessage, decorator: Google::Apis::ClouddebuggerV2::FormatMessage::Representation
      
          property :refers_to, as: 'refersTo'
        end
      end
      
      class UpdateActiveBreakpointResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
    end
  end
end
